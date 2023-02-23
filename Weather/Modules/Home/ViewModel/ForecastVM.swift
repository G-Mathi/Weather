//
//  ForecastVM.swift
//  Weather
//
//  Created by Mathi on 2023-02-18.
//

import Foundation

class ForecastVM: NSObject {
    
    // MARK: - Variables
    
    var forecast: Forecast?
    
    // Weather Data for 7 Days
    var dailyWeatherInfo: [DailyForecast] = []

    func getHourlyForecastInfo() -> [WeatherInfo]? {
        return forecast?.hourly
    }
    
    func getDailyForecastInfo() -> [WeatherInfoDaily]? {
        return forecast?.daily
    }
    
    func getWeatherInfo(at index: Int) -> DailyForecast {
        return dailyWeatherInfo[index]
    }
    
    func getWeatherDataCount() -> Int {
        return dailyWeatherInfo.count
    }
}

// MARK: - GET WeatherData

extension ForecastVM {
    
    func prepLocationForRequest(location: (lat: Double, lon: Double)) -> WeatherRequest {
        let keys = Keys(resourceName: "Keys")
        let weatherRequest = WeatherRequest(
            lat: location.lat,
            lon: location.lon,
            appID: keys.Weather_API_Key
        )
        return weatherRequest
    }
     
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
                    message = "Please update the app to continue..."
                case .clientError, .serverError, .noData, .dataDecodingError:
                    message = "Please try again later..."
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
        return "H: \(getTemperature(for: max))   L: \(getTemperature(for: min))"
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

    // Getting 24 Hours data from 48 Hours Data array
    func getWeatherInfoFor24Hours() -> [HourlyForecast] {
        var weatherInfo24Hour: [HourlyForecast] = []
        
        weatherInfo24Hour = getHourlyForecastInfo()?.enumerated().filter { $0.offset < 24 }.map { getWeatherInfoPerHour(for: $0.element) } ?? []
        
        /*
        getHourlyForecastInfo()?.forEach({ weatherInfoHour in
            weatherInfo24Hour.append(getWeatherInfoPerHour(for: weatherInfoHour))
        })
         */
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
            temperatureRange: "H: \(getTemperature(for: maxTemp))   L:\(getTemperature(for: minTemp))"
        )
        return dailyForecast
    }
}
