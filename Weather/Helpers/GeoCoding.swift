//
//  GeoCoding.swift
//  Weather
//
//  Created by Mathi on 2023-02-23.
//

import Foundation
import CoreLocation

public enum GeocodingError: Error {
    case failedToretrieve
    case noMatchingAddress
}

open class GeoCode {
    
    open class func reverseGeocoding(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping (Result<String, GeocodingError>) -> Void) {
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        geocoder.reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            if error != nil {
                completion(.failure(.failedToretrieve))
                return
            }
            
            if let placemarks = placemarks, let placemark = placemarks.first {
                completion(.success(getAddressInfo(for: placemark)))
            } else {
                completion(.failure(.noMatchingAddress))
            }
        })
    }
    
    open class func getAddressInfo(for placemark: CLPlacemark) -> String {
        if let name = placemark.name {
            return name
        } else if let thoroughfare = placemark.thoroughfare {
            return thoroughfare
        } else if let subThoroughfare = placemark.subThoroughfare {
            return subThoroughfare
        } else if let locality = placemark.locality {
            return locality
        } else if let administrativeArea = placemark.administrativeArea {
            return administrativeArea
        } else if let country = placemark.country {
            return country
        }
        return ""
    }
}
