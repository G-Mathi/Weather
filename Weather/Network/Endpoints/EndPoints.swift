//
//  EndPoints.swift
//  Weather
//
//  Created by Mathi on 2023-02-19.
//

import Foundation

enum EndPoint {
    case getWeatherForecast(path: String = "onecall", queryItems: [URLQueryItem]? = nil)
    
    var request: URLRequest? {
        guard let url = url else { return nil }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = httpMethod
        request.addValues()
        
        return request
    }
    
    private var url: URL? {
        var components = URLComponents()
        
        components.scheme = HTTP.Scheme.https.rawValue
        components.host = host
        components.path = path
        components.queryItems = queryItems
        
        return components.url
    }
    
    private var host: String {
        let domain = APIEnvironment.current().domain()
        let subDomain = APIEnvironment.current().subdomain()
        return "\(subDomain).\(domain)"
    }
    
    private var path: String {
        let route = APIEnvironment.current().route()
        switch self {
        case .getWeatherForecast(let path, _):
            return route + path
        }
    }
    
    private var httpMethod: String {
        switch self {
        case .getWeatherForecast:
            return HTTP.Method.get.rawValue
        }
    }
    
    private var queryItems: [URLQueryItem]? {
        switch self {
        case .getWeatherForecast(_, let queryItems):
            return queryItems
        }
    }
}
