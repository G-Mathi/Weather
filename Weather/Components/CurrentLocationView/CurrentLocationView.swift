//
//  CurrentLocationView.swift
//  Weather
//
//  Created by Mathi on 2023-02-19.
//

import UIKit

struct CurrentLocationInfo {
    var location: (lat: Double, lon: Double) = (12,12)
    var currentTemperatire: String = 296.convertTemperature(from: .kelvin, to: .celsius)
    var minMaxTemperature: String = "H: 34  L: 28"
    
    var time: String = "Today 05:50 AM"
    var weatherDescription: String = "Mostly Clear"
    var pressure: Int = 2343
    var humidity: Int = 67
    var windSpeed: Double = 37.0
}

class CurrentLocationView: UIStackView {

    // MARK: - Components
    
    private var lblLocation: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 24, weight: .regular)
        return label
    }()
    
    private var lblCurrentTemp: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 42, weight: .regular)
        return label
    }()
    
    private var lblMaxMinTemp: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    // MARK: - Init View
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - SetUI
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUI()
    }
}

// MARK: - Configure

extension CurrentLocationView {
    
    func configure(with model: CurrentLocationInfo) {
        lblCurrentTemp.text = model.currentTemperatire
        lblMaxMinTemp.text = model.minMaxTemperature
        
        GeoCode.reverseGeocoding(
            latitude: model.location.lat,
            longitude: model.location.lon) { [weak self] result in
                
            switch result {
            case .success(let locationName):
                self?.lblLocation.text = locationName
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - SetUI

extension CurrentLocationView {
    
    private func addViews() {
        self.addArrangedSubview(lblLocation)
        self.addArrangedSubview(lblCurrentTemp)
        self.addArrangedSubview(lblMaxMinTemp)
    }
    
    private func setUI() {
       self.axis = .vertical
       self.alignment = .center
       self.distribution = .fill
       self.spacing = 0
    }
}


