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
        container.addSubview(hourlyForecastView)
    }
    
    private func setUI() {
        setContainer()
        setHourlyForecastView()
    }
    
    private func setContainer() {
        let constraintsContainer = [
            container.topAnchor.constraint(equalTo: self.topAnchor),
            container.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            container.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            container.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(constraintsContainer)
    }
    
    private func setHourlyForecastView() {
        let constraintsHourlyForecastView = [
            hourlyForecastView.topAnchor.constraint(equalTo: container.topAnchor),
            hourlyForecastView.rightAnchor.constraint(equalTo: container.rightAnchor),
            hourlyForecastView.leftAnchor.constraint(equalTo: container.leftAnchor),
            hourlyForecastView.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraintsHourlyForecastView)
    }
}
