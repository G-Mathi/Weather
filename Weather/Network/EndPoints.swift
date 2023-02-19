//
//  EndPoints.swift
//  Weather
//
//  Created by dilax on 2023-02-19.
//

import Foundation

enum HTTP {
    enum Method: String {
        case get = "GET"
        case post = "POST"
    }
    
    enum Header {
        enum Field: String {
            case contentType = "Content-Type"
        }
        
        enum Value: String {
            case json = "application/json"
        }
    }
}

extension URLRequest {
    mutating func addValues() {
        setValue(HTTP.Header.Value.json.rawValue, forHTTPHeaderField: HTTP.Header.Field.contentType.rawValue)
    }
}

enum EndPoint {
    case getCurrentWeather(path: String = "/data/2.5/weather")
    
    var request: URLRequest? {
        guard let url = url else { return nil }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = httpMethod
        request.addValues()
        
        return request
    }
    
    private var url: URL? {
        var components = URLComponents()
        
        components.scheme = ""
        components.host = ""
        components.path = path
        
        return components.url
    }
    
    private var path: String {
        switch self {
        case .getCurrentWeather(let path):
            return path
        }
    }
    
    private var httpMethod: String {
        switch self {
        case .getCurrentWeather:
            return HTTP.Method.post.rawValue
        }
    }
}
