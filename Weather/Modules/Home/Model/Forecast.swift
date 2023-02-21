//
//  Forecast.swift
//  Weather
//
//  Created by Mathi on 2023-02-20.
//

import Foundation

// MARK: - Forecast

struct Forecast: Codable {
    var lat: Double?
    var lon: Double?
    var timezone: String?
    var timezoneOffset: Double?
    var current: WeatherInfo?
    var hourly: [WeatherInfo]?
    var daily: [WeatherInfoDaily]?
    
    enum CodingKeys: String, CodingKey {
        case lat, lon, timezone
        case timezoneOffset = "timezone_offset"
        case current, hourly, daily
    }
}

// MARK: - Weather Info

struct WeatherInfo: Codable {
    var dt: Int?
    var temp: Double?
    var feelsLike: Double?
    var weather: [WeatherDescription]?
    
    enum CodingKeys: String, CodingKey {
        case dt, temp
        case feelsLike = "feels_like"
        case weather
    }
}

// MARK: - Weather Info Daily

struct WeatherInfoDaily: Codable {
    var dt: Int?
    var sunrise: Int?
    var sunset: Int?
    var temp: Temp?
    var feelsLike: FeelsLike?
    var weather: [WeatherDescription]?
    
    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp
        case feelsLike = "feels_like"
        case weather
    }
}

// MARK: - Other

struct WeatherDescription: Codable {
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
}

struct Temp: Codable {
    var day: Double?
    var min: Double?
    var max: Double?
    var night: Double?
    var eve: Double?
    var morn: Double?
}

struct FeelsLike: Codable {
    var day: Double?
    var night: Double?
    var eve: Double?
    var morn: Double?
}
