//
//  ForecastVM.swift
//  Weather
//
//  Created by Mathi on 2023-02-18.
//

import Foundation
import CoreLocation

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
    
    var locationManger: CLLocationManager?
    
    
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

// MARK: - Display Format Helper

extension ForecastVM {
    
    func getLocationNameFor(lat: Double, lon: Double) -> String {
        return String()
    }
    
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
              let currentDay = forecast.daily?.first,
              let minTemp = currentDay.temp?.min,
              let maxTemp = currentDay.temp?.max
        else {
            return CurrentLocationInfo()
        }
        
        let currentLocationInfo = CurrentLocationInfo(
            location: getLocationNameFor(lat: lat, lon: lon),
            currentTemperatire: getTemperature(for: currentTemperature),
            minMaxTemperature: getMinMaxCurrentDay(min: minTemp, max: maxTemp)
        )
        return currentLocationInfo
    }
}

// MARK: - Forecast For 24 Hour

extension ForecastVM {

    func getWeatherInfoFor24Hours() -> [HourlyForecast] {
        var weatherInfo24Hour: [HourlyForecast] = []
        
        getHourlyForecastInfo()?.forEach({ weatherInfoHour in
            weatherInfo24Hour.append(getWeatherInfoPerHour(for: weatherInfoHour))
        })
        
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
            minTemperature: getTemperature(for: minTemp),
            maxTemperature: getTemperature(for: maxTemp)
        )
        return dailyForecast
    }
}

// MARK: - Requests

extension ForecastVM {
    
    #warning("Change the completion type")
    func getWeatherForecast(completion: @escaping (Bool) -> Void) {
        let forcastQuery: [URLQueryItem] = [
            URLQueryItem(name: "lat", value: "51.507351"),
            URLQueryItem(name: "lon", value: "-0.127758"),
            URLQueryItem(name: "appid", value: "a013dc27d569ced7c7c5d28937e3b87e")
        ]
        
        guard let request = EndPoint.getWeatherForecast(queryItems: forcastQuery).request else { return }
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error {
                #warning("handle error")
                print("Error is \(error.localizedDescription)")
            }
            
            if let data {
                do {
                    let forecast = try JSONDecoder().decode(Forecast.self, from: data)
                    self?.forecast = forecast
                    
                    #warning("Remove")
                    print(forecast)
                    
                } catch(let err) {
                    #warning("handle error")
                    print(err)
                }
            }
        }.resume()
    }
}

// MARK: - CLLocation Manager

extension ForecastVM {
    
    func checkIfLocationServicesEnabled() {
        
        if CLLocationManager.locationServicesEnabled() {
            locationManger = CLLocationManager()
            locationManger?.desiredAccuracy = kCLLocationAccuracyBest
            locationManger?.delegate = self
        } else {
            #warning("Show alert to enable location")
            // Show alert
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManger = locationManger else { return }
        
        switch locationManger.authorizationStatus {
        case .notDetermined:
            locationManger.requestWhenInUseAuthorization()
        case .restricted:
            #warning("Show alert to enable location")
            // Show alert for restricted. eg => Parental control
            break
        case .denied:
            #warning("Show alert to enable location")
            // Show alert to allow location again
            break
        case .authorizedAlways, .authorizedWhenInUse:
            guard let location = locationManger.location else { return }
            print("Coordinates: \(location.coordinate)")
            break
        @unknown default:
            #warning("Show alert for unknown")
            // Show Alert for unknown
            break
        }
    }
}

// MARK: - CLLocation Manager Delegate

extension ForecastVM: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
