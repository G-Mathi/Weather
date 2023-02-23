//
//  HomeVC.swift
//  Weather
//
//  Created by Mathi on 2023-02-18.
//

import UIKit
import CoreLocation

// London - (51.507351, -0.127758)

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
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
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
        
        setupUI()
        setLocationManger()
    }
    
    // MARK: - SetupUI
    
    private func setupUI() {
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
        currentLocationView.configure(with: vm.getCurrentLocationInfo())
        forcastViewHeader.configure(with: vm)
        
        // Need configuration method for this
        vm.dailyWeatherInfo = vm.getWeatherInfoFor7Days()
        self.forecastTableView.reloadData()
    }
}

// MARK: - API Request

extension HomeVC {
    
    private func getWeatherDataAndConfigure(for location: (lat: Double, lon: Double)) {
        
        let currentLocationRequest = vm.prepLocationForRequest(location: location)
        
        vm.getWeatherForecast(at: currentLocationRequest) { [unowned self] success, message  in
            if success {
                DispatchQueue.main.async { [unowned self] in
                    self.configure()
                }
            } else {
                if let message {
                    DispatchQueue.main.async { [unowned self] in
                        AlertProvider.showAlert(target: self, title: AlertStrings.Alert.rawValue, message: message, action: AlertAction(title: AlertStrings.Dismiss.rawValue))
                    }
                }
            }
        }
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
            AlertProvider.showAlert(target: self, title: AlertStrings.Sorry.rawValue, message: AlertStrings.LocationRestricted.rawValue, action: AlertAction(title: AlertStrings.Dismiss.rawValue))
        case .denied:
            AlertProvider.showAlertWithActions(target: self, title: AlertStrings.LocationDeniedTitle.rawValue, message: AlertStrings.LocationDenied.rawValue, actions: [AlertAction(title: AlertStrings.Cancel.rawValue), AlertAction(title: AlertStrings.Confirm.rawValue)]) { [weak self] action in
                if action.title == AlertStrings.Confirm.rawValue {
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                } else {
                    // Show alternative location
                    // London - (51.507351, -0.127758)
                    let london: (lat: Double, lon: Double) = (51.507351, -0.127758)
                    self?.getWeatherDataAndConfigure(for: (london.lon, lon: london.lat))
                }
            }
        case .authorizedAlways, .authorizedWhenInUse:
            guard let location = manager.location else { return }
            getWeatherDataAndConfigure(for: (location.coordinate.latitude, location.coordinate.longitude))
        @unknown default:
            break
        }
    }
}
