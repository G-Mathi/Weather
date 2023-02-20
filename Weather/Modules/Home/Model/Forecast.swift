//
//  Forecast.swift
//  Weather
//
//  Created by Mathi on 2023-02-20.
//

import Foundation

// MARK: - Forecast

struct Forecast {
    var lat: Double
    var lon: Double
    var timezone: String
    var timezoneOffset: Double
    var current: WeatherInfo
    var hourly: [WeatherInfo]
    var daily: [WeatherInfoDaily]
}

// MARK: - Weather Info

struct WeatherInfo {
    var dt: UInt
    var sunrise: UInt
    var sunset: UInt
    var temp: Double
    var feelsLike: Double
    var weather: [WeatherDescription]
//    var pressure: Int
//    var humidity: Int
//    var dew_point: Double
//    var uvi: Int
//    var clouds: Int
//    var visibility: Int
//    var wind_speed: Double
//    var wind_deg: Int
}

struct WeatherDescription {
    var id: Int
    var main: String
    var description: String
    var icon: String
}

// MARK: - Weather Info Daily

struct WeatherInfoDaily {
    var dt: UInt
    var sunrise: UInt
    var sunset: UInt
    var temp: Temp
    var feelsLike: FeelsLike
    var weather: [WeatherDescription]
}

struct Temp {
    var day: Double
    var min: Double
    var max: Double
    var night: Double
    var eve: Double
    var morn: Double
}

struct FeelsLike {
    var day: Double
    var night: Double
    var eve: Double
    var morn: Double
}
