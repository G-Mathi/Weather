//
//  LocationManger.swift
//  Weather
//
//  Created by Mathi on 2023-02-21.
//

import Foundation
import CoreLocation

class LocationProvider: NSObject {
    
    var locationManager: CLLocationManager?
}

// MARK: - Location Enabled/Not

extension LocationProvider {
    
    func checkIfLocationServicesEnabled() {
        locationManager = CLLocationManager()
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.startUpdatingLocation()
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            // Show alert for restricted. eg => Parental control
            break
        case .denied:
            // Show alert to allow location again
            break
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
//            locationManager.startUpdatingLocation()
        @unknown default:
            // Show Alert for unknown
            break
        }
    }
}

// MARK: - CLLocation Manager Delegate

extension LocationProvider: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first {
            manager.stopUpdatingLocation()
            
            print("Location: \(location.coordinate.latitude), \(location.coordinate.longitude) \n\n")
        }
        
//        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
//
//        print(locValue.latitude)
//        print(locValue.longitude)
        
    }
}
