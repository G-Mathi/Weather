//
//  HourlyForecastVM.swift
//  Weather
//
//  Created by Mathi on 2023-02-21.
//

import Foundation

struct HourlyForecast {
    var time: String = ""
    var temperature: String = ""
    var icon: String = ""
}

class HourlyForecastVM {
    
    var hourlyWeatherInfo: [HourlyForecast] = []
    
    func getWeatherInfo(at index: Int) -> HourlyForecast {
        return hourlyWeatherInfo[index]
    }
    
    func getWeatherDataCount() -> Int {
        return hourlyWeatherInfo.count
    }
}
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    func getWeatherInfoAt(for index: Int) -> WeatherInfo? {
//        return hourlyWeatherInfo?[index]
//    }
//
//    func getCellData(for weatherInfoAt: WeatherInfo?) -> HourlyForecast {
//
//        guard let weatherInfoAt,
//              let timeStamp = weatherInfoAt.dt,
//              let temperature = weatherInfoAt.temp,
//              let icon = weatherInfoAt.weather?.first?.icon
//        else {
//            return HourlyForecast()
//        }
//
//        let hourlyForecast = HourlyForecast(
//            time: getTime(for: timeStamp),
//            temperature: getTemperature(for: temperature),
//            icon: getIcon(for: icon)
//        )
//        return hourlyForecast
//    }
//
//    private func getTime(for timeStamp: Double) -> String {
//        return timeStamp.getOnlyHour()
//    }
//
//    private func getTemperature(for temp: Double) -> String {
//        return temp.convertTemperature(from: .kelvin, to: .celsius)
//    }
//
//    private func getIcon(for id: String) -> String {
//        return id.getIconURL()
//    }
//}
