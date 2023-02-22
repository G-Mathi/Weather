//
//  WeatherAPI.swift
//  Weather
//
//  Created by Mathi on 2023-02-22.
//

import Foundation

open class WeatherAPI {
    
    public static let session = URLSession.shared
    
    open class func getWeatherWithRequestBuilder(for weatherRequest: WeatherRequest) -> URLRequest? {
        let forecastQuery: [URLQueryItem] = [
            URLQueryItem(name: "lat", value: String(weatherRequest.lat)),
            URLQueryItem(name: "lon", value: String(weatherRequest.lon)),
            URLQueryItem(name: "appid", value: weatherRequest.appID)
        ]
        
        return EndPoint.getWeatherForecast(queryItems: forecastQuery).request
    }
    
    open class func getData(for request: URLRequest?, completion: @escaping (Result<Forecast, RequestError>) -> Void) {
        
        guard let request else {
            completion(.failure(.invalidRequest))
            return
        }
        
        session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(.failure(.clientError))
                return
            }
            
            guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                completion(.failure(.serverError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decodedData: Forecast = try JSONDecoder().decode(Forecast.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.dataDecodingError))
            }
        }.resume()
    }
}

