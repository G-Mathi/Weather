//
//  CurrentLocationIntroView.swift
//  Weather
//
//  Created by Mathi on 2023-02-23.
//

import UIKit
    
class CurrentLocationIntroView: UIView {
    
    // MARK: - Components
    
    // Background image
    private var imageViewBackground: UIImageView!
    
    // Basic info
    private var locationStack: ImageLabelView!
    private var labelTime: UILabel!
    
    // Current weather info
    private var currentWeatherContainer: UIStackView!
    private var lblCurrentTemperature: UILabel!
    private var lblTemperatureDescription: UILabel!
    private var lblMinMaxTemperature: UILabel!
    
    // Other weather info
    private var otherContainer: UIStackView!
    private var pressureStack: ImageLabelView!
    private var humidityStack: ImageLabelView!
    private var windSpeedStack: ImageLabelView!
    
    // MARK: - Init View
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

    }
    
    func setUI() {
        setBackgroundImage()
        setLocationStack()
        setTimeLabel()
        setCurrentWeather()
        setLabelsForWeather()
        setOtherContainer()
    }
}

// MARK: - Configure

extension CurrentLocationIntroView {
    
    func configure(with model: CurrentLocationInfo) {
        locationStack.configure(with: ImageLabel(icon: "", title: model.location))
        labelTime.text = model.time
        
        lblCurrentTemperature.text = model.currentTemperatire
        lblTemperatureDescription.text = model.weatherDescription
        lblMinMaxTemperature.text = model.minMaxTemperature
    
        pressureStack.configure(with: ImageLabel(icon: "", title: "\(model.pressure) hpa"))
        humidityStack.configure(with: ImageLabel(icon: "", title: "\(model.humidity) %"))
        windSpeedStack.configure(with: ImageLabel(icon: "", title: "\(model.windSpeed) km/h"))
    }
}

// MARK: - Set Background Image

extension CurrentLocationIntroView {
    
    private func setBackgroundImage() {
        imageViewBackground = UIImageView()
        imageViewBackground.translatesAutoresizingMaskIntoConstraints = false
        imageViewBackground.contentMode = .scaleAspectFill
        imageViewBackground.clipsToBounds = true
        imageViewBackground.layer.masksToBounds = true
        imageViewBackground.backgroundColor = .clear
        
        self.addSubview(imageViewBackground)
        
        let constraintsImageViewBackground = [
            imageViewBackground.topAnchor.constraint(equalTo: self.topAnchor),
            imageViewBackground.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            imageViewBackground.leftAnchor.constraint(equalTo: self.leftAnchor),
            imageViewBackground.rightAnchor.constraint(equalTo: self.rightAnchor)
        ]
        NSLayoutConstraint.activate(constraintsImageViewBackground)
    }
}

// MARK: - Set Location and Time

extension CurrentLocationIntroView {
    
    private func setLocationStack() {
        locationStack = ImageLabelView()
        locationStack.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(locationStack)
        
        let constraintsLocationStack = [
            locationStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            locationStack.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16)
        ]
        NSLayoutConstraint.activate(constraintsLocationStack)
    }
    
    private func setTimeLabel() {
        labelTime = UILabel()
        labelTime.translatesAutoresizingMaskIntoConstraints = false
        labelTime.numberOfLines = 1
        labelTime.font = .systemFont(ofSize: 14)
        
        self.addSubview(labelTime)
        
        let constraintsLabelTime = [
            labelTime.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            labelTime.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16)
        ]
        NSLayoutConstraint.activate(constraintsLabelTime)
    }
}

// MARK: - Set Current Weather

extension CurrentLocationIntroView {
    
    private func setCurrentWeather() {
        currentWeatherContainer = UIStackView()
        currentWeatherContainer.translatesAutoresizingMaskIntoConstraints = false
        currentWeatherContainer.axis = .vertical
        currentWeatherContainer.alignment = .center
        currentWeatherContainer.distribution = .fill
        currentWeatherContainer.spacing = 8
    
        self.addSubview(currentWeatherContainer)
        
        let constraintsCurrentWeather = [
            currentWeatherContainer.topAnchor.constraint(equalTo: locationStack.bottomAnchor, constant: 20),
            currentWeatherContainer.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ]
        NSLayoutConstraint.activate(constraintsCurrentWeather)
        
        setLabelsForWeather()
        addViewsToCurrentWeather()
    }
    
    private func setLabelsForWeather() {
        // Current Temperature
        lblCurrentTemperature = UILabel()
        lblCurrentTemperature.numberOfLines = 1
        lblCurrentTemperature.font = .systemFont(ofSize: 14)
        
        // Temperature Description
        lblTemperatureDescription = UILabel()
        lblTemperatureDescription.numberOfLines = 1
        lblTemperatureDescription.font = .systemFont(ofSize: 14)
        
        // Minimum & Maximum Temperatures
        lblMinMaxTemperature = UILabel()
        lblMinMaxTemperature.numberOfLines = 1
        lblMinMaxTemperature.font = .systemFont(ofSize: 14)
    }
    
    private func addViewsToCurrentWeather() {
        currentWeatherContainer.addArrangedSubview(lblCurrentTemperature)
        currentWeatherContainer.addArrangedSubview(lblTemperatureDescription)
        currentWeatherContainer.addArrangedSubview(lblMinMaxTemperature)
    }
}

// MARK: - Set Other Containers

extension CurrentLocationIntroView {
    
    private func setOtherContainer() {
        otherContainer = UIStackView()
        otherContainer.translatesAutoresizingMaskIntoConstraints = false
        otherContainer.axis = .horizontal
        otherContainer.alignment = .fill
        otherContainer.distribution = .fillEqually
        otherContainer.spacing = 0
    
        self.addSubview(otherContainer)
        
        let constraintsOtherContainer = [
            otherContainer.topAnchor.constraint(equalTo: currentWeatherContainer.bottomAnchor, constant: 20),
            otherContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 16),
            otherContainer.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            otherContainer.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16)
        ]
        NSLayoutConstraint.activate(constraintsOtherContainer)
        
        setComponentsForOther()
        addViewsToOtherContainer()
    }
    
    private func setComponentsForOther() {
        pressureStack = ImageLabelView()
        humidityStack = ImageLabelView()
        windSpeedStack = ImageLabelView()
    }
    
    private func addViewsToOtherContainer() {
        otherContainer.addArrangedSubview(pressureStack)
        otherContainer.addArrangedSubview(humidityStack)
        otherContainer.addArrangedSubview(windSpeedStack)
    }
}
