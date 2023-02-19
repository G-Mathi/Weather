//
//  HourlyForecastCVCell.swift
//  Weather
//
//  Created by dilax on 2023-02-19.
//

import UIKit

class HourlyForecastCVCell: UICollectionViewCell {
    static let identifier = "HourlyForecastCVCell"
    
    // MARK: - Components
    
    private let container: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 0
        
        stackView.backgroundColor = .green
        return stackView
    }()
    
    private let lblTime: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let lblTemperature: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    // MARK: - Init View
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - SetUI
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        lblTime.text = nil
        imageView.image = nil
        lblTemperature.text = nil
    }
}

// MARK: - Configure

extension HourlyForecastCVCell {
    
    func configure() {
        lblTime.text = ""
        imageView.image = UIImage()
        lblTemperature.text = ""
    }
}

// MARK: - Set

extension HourlyForecastCVCell {
    
    private func addViews() {
        container.addArrangedSubview(lblTime)
        container.addArrangedSubview(imageView)
        container.addArrangedSubview(lblTemperature)
    }
}
