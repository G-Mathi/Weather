//
//  HomeVM.swift
//  Weather
//
//  Created by Mathi on 2023-02-18.
//

import Foundation
import CoreLocation

class HomeVM: NSObject {
    
    // MARK: - Variables
    
    var forcast: Forecast?
    
    var locationManger: CLLocationManager?
    
    func getCurrentLocationName(with coordinates: CLLocationCoordinate2D) {
        
    }
    
    func getCurrentTemperatureInfo() -> WeatherInfo? {
        return forcast?.current
    }
    
    func getHourlyForecastInfo() -> [WeatherInfo]? {
        return forcast?.hourly
    }
    
    func getDailyForecastInfo() -> [WeatherInfoDaily]? {
        return forcast?.daily
    }
    
}

// MARK: - Requests

extension HomeVM {
    
    #warning("Change the completion type")
    func getWeatherForecast(completion: @escaping (Bool) -> Void) {
        let forcastQuery: [URLQueryItem] = [
            URLQueryItem(name: "lat", value: "51.507351"),
            URLQueryItem(name: "lon", value: "-0.127758"),
            URLQueryItem(name: "appid", value: "a013dc27d569ced7c7c5d28937e3b87e")
        ]
        
        guard let request = EndPoint.getWeatherForecast(queryItems: forcastQuery).request else { return }
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error {
                #warning("handle error")
                print("Error is \(error.localizedDescription)")
            }
            
            if let data {
                do {
                    let forecast = try JSONDecoder().decode(Forecast.self, from: data)
                    self?.forcast = forecast
                    
                    #warning("Remove")
                    print(forecast)
                    
                } catch(let err) {
                    #warning("handle error")
                    print(err)
                }
            }
        }.resume()
    }
}

// MARK: - CLLocation Manager

extension HomeVM {
    
    func checkIfLocationServicesEnabled() {
        
        if CLLocationManager.locationServicesEnabled() {
            locationManger = CLLocationManager()
            locationManger?.desiredAccuracy = kCLLocationAccuracyBest
            locationManger?.delegate = self
        } else {
            #warning("Show alert to enable location")
            // Show alert
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManger = locationManger else { return }
        
        switch locationManger.authorizationStatus {
        case .notDetermined:
            locationManger.requestWhenInUseAuthorization()
        case .restricted:
            #warning("Show alert to enable location")
            // Show alert for restricted. eg => Parental control
            break
        case .denied:
            #warning("Show alert to enable location")
            // Show alert to allow location again
            break
        case .authorizedAlways, .authorizedWhenInUse:
            guard let location = locationManger.location else { return }
            print("Coordinates: \(location.coordinate)")
            break
        @unknown default:
            #warning("Show alert for unknown")
            // Show Alert for unknown
            break
        }
    }
}

// MARK: - CLLocation Manager Delegate

extension HomeVM: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
