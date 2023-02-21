//
//  ForecastViewHeader.swift
//  Weather
//
//  Created by Mathi on 2023-02-20.
//

import UIKit

class ForecastViewHeader: UIView {

    // MARK: - Components
    
    private let container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.backgroundColor = .clear
        return view
    }()

//    /// Current Temperature View
//    private var currentTemperatureView: CurrentTemperatureView = {
//        let stackView = CurrentTemperatureView()
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.layer.cornerRadius = 12
//
//        stackView.backgroundColor = .orange
//        return stackView
//    }()
    
    /// Hourly Temperature View
    private var hourlyForecastView: HourlyForecastView = {
        let view = HourlyForecastView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.backgroundColor = .clear
        return view
    }()
    
    // MARK: - Init View
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError()
    }
    
    // MARK: - SetUI
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setUI()
    }
}

// MARK: - Configure

extension ForecastViewHeader {
    
    func configure(with vm: ForecastVM) {
        hourlyForecastView.configure(with: vm.getWeatherInfoFor24Hours())
    }
}

// MARK: - SetUI

extension ForecastViewHeader {
    
    private func addViews() {
        self.addSubview(container)
//        container.addSubview(currentTemperatureView)
        container.addSubview(hourlyForecastView)
    }
    
    private func setUI() {
        setContainer()
//        setCurrentTemperatureView()
        setHourlyForecastView()
    }
    
    private func setContainer() {
        let constraintsContainer = [
            container.topAnchor.constraint(equalTo: self.topAnchor),
            container.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            container.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            container.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16)
        ]
        NSLayoutConstraint.activate(constraintsContainer)
    }
    
//    private func setCurrentTemperatureView() {
//        let constraintsCurrentTemperatureView = [
//            currentTemperatureView.topAnchor.constraint(equalTo: container.topAnchor),
//            currentTemperatureView.rightAnchor.constraint(equalTo: container.rightAnchor),
//            currentTemperatureView.leftAnchor.constraint(equalTo: container.leftAnchor)
//        ]
//        NSLayoutConstraint.activate(constraintsCurrentTemperatureView)
//    }
    
    private func setHourlyForecastView() {
        let constraintsHourlyForecastView = [
//            hourlyForecastView.topAnchor.constraint(equalTo: currentTemperatureView.bottomAnchor),
            hourlyForecastView.topAnchor.constraint(equalTo: container.topAnchor),
            
            hourlyForecastView.rightAnchor.constraint(equalTo: container.rightAnchor),
            hourlyForecastView.leftAnchor.constraint(equalTo: container.leftAnchor),
            hourlyForecastView.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraintsHourlyForecastView)
    }
}
