//
//  ForecastVM.swift
//  Weather
//
//  Created by Mathi on 2023-02-18.
//

import Foundation

// London - (51.507351, -0.127758)

class ForecastVM: NSObject {
    
    #warning("Need to relocate where good")
    // MARK: - Weather Data for 7 Days
    
    var dailyWeatherInfo: [DailyForecast] = []
    
    func getWeatherInfo(at index: Int) -> DailyForecast {
        return dailyWeatherInfo[index]
    }
    
    func getWeatherDataCount() -> Int {
        return dailyWeatherInfo.count
    }
    
    // MARK: - Variables
    
    var forecast: Forecast?
    
    func prepLocationForRequest(location: (lat: Double, lon: Double)) -> WeatherRequest {
        let weatherRequest = WeatherRequest(
            lat: location.lat,
            lon: location.lon,
            appID: "a013dc27d569ced7c7c5d28937e3b87e"
        )
        return weatherRequest
    }
    
    func getCurrentTemperatureInfo() -> WeatherInfo? {
        return forecast?.current
    }
    
    func getHourlyForecastInfo() -> [WeatherInfo]? {
        return forecast?.hourly
    }
    
    func getDailyForecastInfo() -> [WeatherInfoDaily]? {
        return forecast?.daily
    }
}

// MARK: - Get Current Location

extension ForecastVM {
    
    func getCurrentLocation() {
 
    }
}

// MARK: - Requests

extension ForecastVM {
     
    func getWeatherForecast(at request: WeatherRequest, completion: @escaping (Bool, String?) -> Void) {
        request.getWeatherData { [weak self] result in
            switch result {
            case .success(let forecast):
                self?.forecast = forecast
                completion(true, nil)
            case .failure(let error):
                let message: String?
                switch error {
                case .invalidRequest:
                    message = ""
                case .clientError:
                    message = ""
                case .serverError:
                    message = ""
                case .noData:
                    message = ""
                case .dataDecodingError:
                    message = ""
                }
                completion(false, message)
            }
        }
    }
}

// MARK: - Display Format Helper

extension ForecastVM {
    
    private func getTime(for timeStamp: Double) -> String {
        return timeStamp.getOnlyHour()
    }
    
    private func getDay(for timeStamp: Double) -> String {
        return timeStamp.getOnlyDay()
    }
    
    private func getTemperature(for temp: Double) -> String {
        return temp.convertTemperature(from: .kelvin, to: .celsius)
    }
    
    private func getIcon(for id: String) -> String {
        return id.getIconURL()
    }
    
    private func getMinMaxCurrentDay(min: Double, max: Double) -> String {
        return "Min: \(getTemperature(for: min)) Max: \(getTemperature(for: max))"
    }
}

// MARK: - Current Location Info

extension ForecastVM {
    
    func getCurrentLocationInfo() -> CurrentLocationInfo {
        
        guard let forecast,
              let lat = forecast.lat,
              let lon = forecast.lon,
              let currentTemperature = forecast.current?.temp,
              let time = forecast.current?.dt,
              let weatherDescription = forecast.current?.weather?[0].description,
              let pressure = forecast.current?.pressure,
              let humidity = forecast.current?.humidity,
              let windSpeed = forecast.current?.windSpeed,
              let currentDay = forecast.daily?.first,
              let minTemp = currentDay.temp?.min,
              let maxTemp = currentDay.temp?.max
        else {
            return CurrentLocationInfo()
        }
        
        let currentLocationInfo = CurrentLocationInfo(
            location: (lat, lon),
            currentTemperatire: getTemperature(for: currentTemperature),
            minMaxTemperature: getMinMaxCurrentDay(min: minTemp, max: maxTemp),
            time: time.getOnly12Time(),
            weatherDescription: weatherDescription,
            pressure: pressure,
            humidity: humidity,
            windSpeed: windSpeed
        )
        return currentLocationInfo
    }
}

// MARK: - Forecast For 24 Hour

extension ForecastVM {

    func getWeatherInfoFor24Hours() -> [HourlyForecast] {
        var weatherInfo24Hour: [HourlyForecast] = []
        
        for i in 0..<24 {
            weatherInfo24Hour.append(getWeatherInfoPerHour(for: getHourlyForecastInfo()?[i]))
        }
        
//        getHourlyForecastInfo()?.forEach({ weatherInfoHour in
//            weatherInfo24Hour.append(getWeatherInfoPerHour(for: weatherInfoHour))
//        })
        
        return weatherInfo24Hour
    }
    
    func getWeatherInfoPerHour(for weatherInfoHour: WeatherInfo?) -> HourlyForecast {
        
        guard let weatherInfoHour,
              let timeStamp = weatherInfoHour.dt,
              let temperature = weatherInfoHour.temp,
              let weatherIcon = weatherInfoHour.weather?.first?.icon
        else {
            return HourlyForecast()
        }
        
        let hourlyForecast = HourlyForecast(
            time: getTime(for: timeStamp),
            temperature: getTemperature(for: temperature),
            icon: getIcon(for: weatherIcon)
        )
        return hourlyForecast
    }
}

// MARK: - Forecast For 7 Days

extension ForecastVM {
    
    func getWeatherInfoFor7Days() -> [DailyForecast] {
        var weatherFor7Days: [DailyForecast] = []
        
        getDailyForecastInfo()?.forEach({ weatherInfoDay in
            weatherFor7Days.append(getWeatherInfoPerDay(for: weatherInfoDay))
        })
        
        return weatherFor7Days
    }
    
    func getWeatherInfoPerDay(for weatherInfoDay: WeatherInfoDaily?) -> DailyForecast {
        
        guard let weatherInfoDay,
              let timeStamp = weatherInfoDay.dt,
              let minTemp = weatherInfoDay.temp?.min,
              let maxTemp = weatherInfoDay.temp?.max,
              let weatherIcon = weatherInfoDay.weather?.first?.icon
        else {
            return DailyForecast()
        }
        
        let dailyForecast = DailyForecast(
            day: getDay(for: timeStamp),
            icon: getIcon(for: weatherIcon),
            temperatureRange: "H: \(getTemperature(for: maxTemp)) L:\(getTemperature(for: minTemp))"
        )
        return dailyForecast
    }
}
