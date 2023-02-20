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
    
    var locationManger: CLLocationManager?
    
    func getWeatherForecast() {
        let forcastQuery: [URLQueryItem] = [
            URLQueryItem(name: "lat", value: "51.507351"),
            URLQueryItem(name: "lon", value: "-0.127758"),
            URLQueryItem(name: "appid", value: "a013dc27d569ced7c7c5d28937e3b87e")
        ]
        
        guard let request = EndPoint.getWeatherForecast(queryItems: forcastQuery).request else { return }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                print("Error is \(error.localizedDescription)")
            }
            
            if let data {
                do {
                    let post = try JSONDecoder().decode(Forecast.self, from: data)
                    print(post)
                } catch(let err) {
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
            // Show alert
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManger = locationManger else { return }
        
        switch locationManger.authorizationStatus {
        case .notDetermined:
            locationManger.requestWhenInUseAuthorization()
        case .restricted:
            // Show alert for restricted. eg => Parental control
            break
        case .denied:
            // Show alert to allow location again
            break
        case .authorizedAlways, .authorizedWhenInUse:
            guard let location = locationManger.location else { return }
            print("Coordinates: \(location.coordinate)")
            break
        @unknown default:
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
