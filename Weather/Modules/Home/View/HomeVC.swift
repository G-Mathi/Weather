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
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
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
    
    private var hourlyForecastView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .link
        return collectionView
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

// MARK: - Set Hourly Forecast View

extension HomeVC {
    
    private func setHourlyForecastView() {
        view.addSubview(hourlyForecastView)
        
        hourlyForecastView.delegate = self
        hourlyForecastView.dataSource = self
        hourlyForecastView.register(HourlyForecastCVCell.self, forCellWithReuseIdentifier: HourlyForecastCVCell.identifier)
        
        let safeArea = view.safeAreaLayoutGuide
        let constraintsHourlyView = [
            hourlyForecastView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 30),
            hourlyForecastView.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 30),
            hourlyForecastView.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -30),
            hourlyForecastView.heightAnchor.constraint(equalToConstant: 120)
        ]
        NSLayoutConstraint.activate(constraintsHourlyView)
    }
}

// MARK: - Set Daily Forecast View

extension HomeVC {
    
    private func setDailyForecastView() {
        view.addSubview(dailyForecastView)
        
        dailyForecastView.delegate = self
        dailyForecastView.dataSource = self
        dailyForecastView.register(DailyForecastTVCell.self, forCellReuseIdentifier: DailyForecastTVCell.identifier)
        
        let safeArea = view.safeAreaLayoutGuide
        let constraintsDailyView = [
            dailyForecastView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 30),
            dailyForecastView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            dailyForecastView.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 30),
            dailyForecastView.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -30)
        ]
        NSLayoutConstraint.activate(constraintsDailyView)
    }
}

// MARK: - CollectionView Delegate

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let hourlyForeCastCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyForecastCVCell.identifier, for: indexPath) as? HourlyForecastCVCell {
            hourlyForeCastCVCell.configure()
            return hourlyForeCastCVCell
        }
        
        return UICollectionViewCell()
    }
}

// MARK: - TableView Delegate

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let dailyForecastCell = tableView.dequeueReusableCell(withIdentifier: DailyForecastTVCell.identifier, for: indexPath) as? DailyForecastTVCell {
            dailyForecastCell.configure()
            return dailyForecastCell
        }
        return UITableViewCell()
    }
}
