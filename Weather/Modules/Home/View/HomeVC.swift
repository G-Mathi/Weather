//
//  HomeVC.swift
//  Weather
//
//  Created by Mathi on 2023-02-18.
//

import UIKit

class HomeVC: UIViewController {

    // MARK: - Variables
    
    private var vm = HomeVM()
    
    // MARK: Components
    
    private var dailyForecastView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    /// Current Temperature StackView
    private var currentTemperatureView: CurrentTemperatureView = {
        let stackView = CurrentTemperatureView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layer.cornerRadius = 12
        
        stackView.backgroundColor = .orange
        return stackView
    }()
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        configure()
        
//        vm.getWeatherForecast()
        
        // vm.checkIfLocationServicesEnabled()
    }
    
    // MARK: - SetupUI
    
    private func setupUI() {
        self.title = "Home"
        view.backgroundColor = .systemBackground
        
//        setTemperatureView()
//        setHourlyForecastView()
        setDailyForecastView()
    }
    
    // MARK: - Configure
    
    private func configure() {
        
    }
}

// MARK: - Set Temperature View

extension HomeVC {
    
    private func setTemperatureView() {
        view.addSubview(currentTemperatureView)
        
        let safeArea = view.safeAreaLayoutGuide
        let constraintsCurrentTempView = [
            currentTemperatureView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 30),
            currentTemperatureView.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 30),
            currentTemperatureView.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -30)
        ]
        NSLayoutConstraint.activate(constraintsCurrentTempView)
        
        currentTemperatureView.configure()
    }
}

// MARK: - Set Daily Forecast View

extension HomeVC {
    
    private func setDailyForecastView() {
        view.addSubview(dailyForecastView)
        
        dailyForecastView.delegate = self
        dailyForecastView.dataSource = self
        
        let header = Header(frame: CGRect(x: 0, y: 0, width: dailyForecastView.frame.size.width, height: 200))
        dailyForecastView.tableHeaderView = header
        
        dailyForecastView.register(DailyForecastTVCell.self, forCellReuseIdentifier: DailyForecastTVCell.identifier)
        
        
        let safeArea = view.safeAreaLayoutGuide
        let constraintsDailyView = [
            dailyForecastView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            dailyForecastView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            dailyForecastView.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            dailyForecastView.rightAnchor.constraint(equalTo: safeArea.rightAnchor)
        ]
        NSLayoutConstraint.activate(constraintsDailyView)
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
