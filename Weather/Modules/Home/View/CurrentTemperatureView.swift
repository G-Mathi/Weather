//
//  CurrentTemperatureView.swift
//  Weather
//
//  Created by Mathi on 2023-02-19.
//

import UIKit

class CurrentTemperatureView: UIStackView {

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
        configure()
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

extension CurrentTemperatureView {
    
    func configure() {
        lblLocation.text = "4th Cross Road"
        lblCurrentTemp.text = 28.getCelciusFormat()
        lblMaxMinTemp.text = "Max: \(32.getCelciusFormat()) Min:\(28.getCelciusFormat())"
    }
}

// MARK: - SetUI

extension CurrentTemperatureView {
    
    private func setUI() {
       self.axis = .vertical
       self.alignment = .center
       self.distribution = .fill
       self.spacing = 0
    }
    
    private func addViews() {
        self.addArrangedSubview(lblLocation)
        self.addArrangedSubview(lblCurrentTemp)
        self.addArrangedSubview(lblMaxMinTemp)
    }
}


