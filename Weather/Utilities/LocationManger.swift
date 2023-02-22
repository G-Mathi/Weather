//
//  LocationManger.swift
//  Weather
//
//  Created by Mathi on 2023-02-21.
//

import Foundation
import CoreLocation

class LocationManager: NSObject {
    
    public static let shared = LocationManager()
    
    var locationManager: CLLocationManager?
    
    private override init() {}
}

// MARK: - CLLocation Manager

extension LocationManager {
    
    func checkIfLocationServicesEnabled() {
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            locationManager?.delegate = self
            locationManager?.startUpdatingLocation()
        } else {
            
            // Show alert
        }
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
            guard let location = locationManager.location else { return }
            print("Coordinates: \(location.coordinate)")
            break
        @unknown default:
            
            // Show Alert for unknown
            break
        }
    }
}

// MARK: - CLLocation Manager Delegate

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        print(locValue.latitude)
        print(locValue.longitude)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("LocationManager didFailWithError \(error.localizedDescription)")
        if let error = error as? CLError, error.code == .denied {
            // Location updates are not authorized.
            // To prevent forever looping of `didFailWithError` callback
            locationManager?.stopMonitoringSignificantLocationChanges()
            return
        }
    }
}
