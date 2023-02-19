//
//  CommonExtentions.swift
//  Weather
//
//  Created by Mathi on 2023-02-19.
//

import Foundation

// MARK: - Temperature Format

extension Double {
    
    func getCelciusFormat() -> String {
        let measurement = Measurement(
            value: self,
            unit: UnitTemperature.celsius
        )

        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.unitStyle = .short
        measurementFormatter.numberFormatter.maximumFractionDigits = 0
        measurementFormatter.unitOptions = .temperatureWithoutUnit
        
        return measurementFormatter.string(from: measurement)
    }
}
