//
//  WeatherRequest.swift
//  Weather
//
//  Created by Mathi on 2023-02-22.
//

import Foundation

public struct WeatherRequest {
    var lat: Double
    var lon: Double
    var appID: String
    
    func getWeatherData(completion: @escaping (Result<Forecast, RequestError>) -> Void) {
        let request = WeatherAPI.getWeatherWithRequestBuilder(for: self)
        
        WeatherAPI.getData(for: request) { result in
            completion(result)
        }
    }
}
