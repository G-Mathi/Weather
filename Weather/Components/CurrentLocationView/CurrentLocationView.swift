//
//  CurrentLocationView.swift
//  Weather
//
//  Created by Mathi on 2023-02-19.
//

import UIKit

struct CurrentLocationInfo {
    var location: String = ""
    var currentTemperatire: String = ""
    var minMaxTemperature: String = ""
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
        lblLocation.text = model.location
        lblCurrentTemp.text = model.currentTemperatire
        lblMaxMinTemp.text = model.minMaxTemperature
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


