//
//  HourlyForecastCVCell.swift
//  Weather
//
//  Created by Mathi on 2023-02-19.
//

import UIKit
import Kingfisher

class HourlyForecastCVCell: UICollectionViewCell {
    static let identifier = "HourlyForecastCVCell"
    
    // MARK: - Components
    
    private let container: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 8
        
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    private let lblTime: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 13)
        label.textColor = .lightGray
        return label
    }()
    
    private var imageViewWeatherIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    private let lblTemperature: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 15, weight: .semibold)
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
        
        setContainer()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        lblTime.text = nil
        imageViewWeatherIcon.image = nil
        lblTemperature.text = nil
    }
}

// MARK: - Configure

extension HourlyForecastCVCell {
    
    func configure(with model: HourlyForecast, currentTime: Bool) {
        lblTime.text = currentTime ? "Now" : model.time
        lblTemperature.text = model.temperature
        
        if let url = URL(string: model.icon) {
            DispatchQueue.global(qos: .userInteractive).async { [weak self] in
                self?.retrieveAndSetImage(for: url)
            }
        }
    }
    
    private func retrieveAndSetImage(for url: URL) {
        let resource = ImageResource(downloadURL: url)
        KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { result in
            switch result {
            case .success(let value):
                DispatchQueue.main.async { [weak self] in
                    self?.imageViewWeatherIcon.image = value.image
                }
            case .failure(_):
                fatalError()
            }
        }
    }
}

// MARK: - SetUI

extension HourlyForecastCVCell {
    
    private func addViews() {
        contentView.addSubview(container)
        container.addArrangedSubview(lblTime)
        container.addArrangedSubview(imageViewWeatherIcon)
        container.addArrangedSubview(lblTemperature)
    }
    
    private func setContainer() {
        let constraintsContainer = [
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            container.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            container.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ]
        NSLayoutConstraint.activate(constraintsContainer)
    }
}
