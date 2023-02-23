//
//  HomeVC.swift
//  Weather
//
//  Created by Mathi on 2023-02-18.
//

import UIKit
import CoreLocation

class HomeVC: UIViewController {
    
    // MARK: - Variables
    
    private var vm = ForecastVM()
    private var locationManager: CLLocationManager?
    
    // MARK: Components
    
    /// Current Temperature View
    private var currentLocationView: CurrentLocationIntroView = {
        let view = CurrentLocationIntroView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        
        // RGB = 22, 40, 63
        view.backgroundColor = UIColor(red: 0.09, green: 0.16, blue: 0.25, alpha: 1.00)
        return view
    }()
    
    private var forecastTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    private var forcastViewHeader: ForecastViewHeader = {
        let header = ForecastViewHeader()
        return header
    }()
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLocationManger()
        
        //        setupUI()
        //        getWeatherDataAndConfigure()
    }
    
    // MARK: - SetupUI
    
    private func setupUI() {
        self.title = "Home"
        
        // RGB = 35, 59, 88
        view.backgroundColor = UIColor(red: 0.14, green: 0.23, blue: 0.35, alpha: 1.00)
        
        setCurrentTemperatureView()
        setDailyForecastView()
        setForcastViewHeader()
    }
}

// MARK: - Configure

extension HomeVC {
    
    private func configure() {
        //        currentLocationView.configure(with: vm.getCurrentLocationInfo())
        currentLocationView.configure(with: CurrentLocationInfo())
        forcastViewHeader.configure(with: vm)
        
        // Need configuration method for this
        vm.dailyWeatherInfo = vm.getWeatherInfoFor7Days()
        forecastTableView.reloadData()
    }
}

// MARK: - Set LocationManger

extension HomeVC {
    
    private func setLocationManger() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestWhenInUseAuthorization()
    }
}

// MARK: - Set Current Temperature View

extension HomeVC {
    
    private func setCurrentTemperatureView() {
        view.addSubview(currentLocationView)
        
        let safeArea = view.safeAreaLayoutGuide
        let constraintsCurrentTemperatureView = [
            currentLocationView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            currentLocationView.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 25),
            currentLocationView.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -25)
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
    
    // MARK: -  Set Header
    
    private func setForcastViewHeader() {
        forcastViewHeader.frame = CGRect(x: 0, y: 0, width: forecastTableView.frame.size.width, height: 100)
        forecastTableView.tableHeaderView = forcastViewHeader
    }
}

// MARK: - API Request

extension HomeVC {
    
    private func getWeatherDataAndConfigure() {
        let currentLocationRequest = vm.prepLocationForRequest(location: (51.507351, -0.127758))
        vm.getWeatherForecast(at: currentLocationRequest) { [weak self] success in
            if success {
                DispatchQueue.main.async { [weak self] in
                    self?.configure()
                }
            } else {
                
            }
        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

// MARK: - CLLocationManager Delegate

extension HomeVC: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        switch manager.authorizationStatus {
        case .notDetermined:
            locationManager?.requestWhenInUseAuthorization()
        case .restricted:
            AlertProvider.showAlert(target: self, title: "", message: "message", action: AlertAction(title: "Dismiss"))
        case .denied:
            AlertProvider.showAlertWithActions(target: self, title: "ds", message: "sfsf", actions: [AlertAction(title: "Cancel"), AlertAction(title: "Go")]) { action in
                if action.title == "Go" {
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                }
            }
        case .authorizedAlways, .authorizedWhenInUse:
            guard let location = manager.location else { return }
            print(location.coordinate)
        @unknown default:
            break
        }
    }
}
