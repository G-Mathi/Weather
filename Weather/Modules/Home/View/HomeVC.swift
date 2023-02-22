//
//  HomeVC.swift
//  Weather
//
//  Created by Mathi on 2023-02-18.
//

import UIKit

class HomeVC: UIViewController {

    // MARK: - Variables
    
    private var vm = ForecastVM()
    
    // MARK: Components
    
    /// Current Temperature View
    private var currentLocationView: CurrentLocationView = {
        let stackView = CurrentLocationView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layer.cornerRadius = 12
        
        stackView.backgroundColor = .orange
        return stackView
    }()
    
    private var forecastTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    private var forcastViewHeader: ForecastViewHeader = {
        let header = ForecastViewHeader()
        return header
    }()
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        configure()
        
        #warning("Find better solution")
        let currentLocationRequest = vm.prepLocationForRequest(location: (51.507351, -0.127758))
        vm.getWeatherForecast(at: currentLocationRequest) { [weak self] success in
            if success {
                DispatchQueue.main.async { [weak self] in
                    self?.configure()
                }
            } else {
                
            }
        }
        
        // vm.checkIfLocationServicesEnabled()
    }
    
    // MARK: - SetupUI
    
    private func setupUI() {
        self.title = "Home"
        view.backgroundColor = .systemBackground
        
        setCurrentTemperatureView()
        setDailyForecastView()
        setForcastViewHeader()
    }
    
    // MARK: - Configure
    
    private func configure() {
        currentLocationView.configure(with: vm.getCurrentLocationInfo())
        forcastViewHeader.configure(with: vm)
        
        // Need configuration method for this
        vm.dailyWeatherInfo = vm.getWeatherInfoFor7Days()
        forecastTableView.reloadData()
    }
}

// MARK: - Set Current Temperature View

extension HomeVC {
    
    private func setCurrentTemperatureView() {
        view.addSubview(currentLocationView)
        
        let safeArea = view.safeAreaLayoutGuide
        let constraintsCurrentTemperatureView = [
            currentLocationView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            currentLocationView.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
            currentLocationView.leftAnchor.constraint(equalTo: safeArea.leftAnchor)
        ]
        NSLayoutConstraint.activate(constraintsCurrentTemperatureView)
    }
}

// MARK: - Set Daily Forecast View

extension HomeVC {
    
    private func setDailyForecastView() {
        view.addSubview(forecastTableView)
        
        forecastTableView.delegate = self
        forecastTableView.dataSource = self
        forecastTableView.register(DailyForecastTVCell.self, forCellReuseIdentifier: DailyForecastTVCell.identifier)
        
        let safeArea = view.safeAreaLayoutGuide
        let constraintsDailyView = [
            forecastTableView.topAnchor.constraint(equalTo: currentLocationView.bottomAnchor),
            forecastTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            forecastTableView.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            forecastTableView.rightAnchor.constraint(equalTo: safeArea.rightAnchor)
        ]
        NSLayoutConstraint.activate(constraintsDailyView)
    }
    
    private func setForcastViewHeader() {
        forcastViewHeader.frame = CGRect(x: 0, y: 0, width: forecastTableView.frame.size.width, height: 200)
        forecastTableView.tableHeaderView = forcastViewHeader
    }
}

// MARK: - TableView Delegate

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.getWeatherDataCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let dailyForecastCell = tableView.dequeueReusableCell(withIdentifier: DailyForecastTVCell.identifier, for: indexPath) as? DailyForecastTVCell {
            dailyForecastCell.configure(with: vm.getWeatherInfo(at: indexPath.row))
            return dailyForecastCell
        }
        return UITableViewCell()
    }
}
