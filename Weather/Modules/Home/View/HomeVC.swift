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
    private var currentTemperatureView: CurrentTemperatureView = {
        let stackView = CurrentTemperatureView()
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
    
    private var forcastViewHeader: UIView = {
        let header = ForecastViewHeader()
        return header
    }()
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        configure()
        
        #warning("Find better solution")
        vm.getWeatherForecast { success in
            if success {
                
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
        currentTemperatureView.configure(with: vm.getCurrentLocationInfo())
    }
}

// MARK: - Set Current Temperature View

extension HomeVC {
    
    private func setCurrentTemperatureView() {
        view.addSubview(currentTemperatureView)
        
        let safeArea = view.safeAreaLayoutGuide
        let constraintsCurrentTemperatureView = [
            currentTemperatureView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            currentTemperatureView.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
            currentTemperatureView.leftAnchor.constraint(equalTo: safeArea.leftAnchor)
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
            forecastTableView.topAnchor.constraint(equalTo: currentTemperatureView.bottomAnchor),
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
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let dailyForecastCell = tableView.dequeueReusableCell(withIdentifier: DailyForecastTVCell.identifier, for: indexPath) as? DailyForecastTVCell {
            dailyForecastCell.configure()
            return dailyForecastCell
        }
        return UITableViewCell()
    }
}
