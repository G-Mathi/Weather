//
//  Constants.swift
//  Weather
//
//  Created by Mathi on 2023-02-20.
//

import Foundation

enum APIEnvironment {
    case development
    case staging
    case production
    
    static func current() -> APIEnvironment {
        return.development
    }
    
    func domain() -> String {
        switch self {
        case .development:
            return "openweathermap.org"
        case .staging:
            return "openweathermap.org"
        case .production:
            return "openweathermap.org"
        }
    }
    
    func subdomain() -> String {
        switch self {
        case .development, .production, .staging:
            return "api"
        }
    }
    
    func route() -> String {
        return "/data/3.0/"
    }
}
