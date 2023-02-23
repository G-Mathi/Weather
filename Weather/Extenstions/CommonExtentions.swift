//
//  CommonExtentions.swift
//  Weather
//
//  Created by Mathi on 2023-02-19.
//

import Foundation

// MARK: - Temperature Format

extension Double {
    
    func convertTemperature(from inputTempType: UnitTemperature, to outputTempType: UnitTemperature) -> String {
        let input = Measurement(value: self, unit: inputTempType)
        let output = input.converted(to: outputTempType)
        
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.unitStyle = .short
        measurementFormatter.numberFormatter.maximumFractionDigits = 0
        measurementFormatter.unitOptions = .temperatureWithoutUnit
        
        return measurementFormatter.string(from: output)
    }
}

// MARK: - Date Format

extension Double {
    
    func getOnly24Time() -> String {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.short
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = .current
        
        return dateFormatter.string(from: date)
    }
    
    func getOnlyHour() -> String {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.short
        dateFormatter.dateFormat = "hh a"
        dateFormatter.timeZone = .current
        
        return dateFormatter.string(from: date)
    }
    
    func getOnlyDay() -> String {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.timeZone = .current
        
        return dateFormatter.string(from: date)
    }
}

// MARK: - Get WeatherIcon URL

extension String {
    
    func getIconURL() -> String {
        return "http://openweathermap.org/img/wn/\(self)@2x.png"
    }
}
