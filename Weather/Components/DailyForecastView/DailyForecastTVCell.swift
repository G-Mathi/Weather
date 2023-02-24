//
//  DailyForecastTVCell.swift
//  Weather
//
//  Created by Mathi on 2023-02-20.
//

import UIKit
import Kingfisher
import AlamofireImage

struct DailyForecast {
    var day: String = ""
    var icon: String = ""
    var temperatureRange: String = ""
}

class DailyForecastTVCell: UITableViewCell {
    static let identifier = "DailyForecastTVCell"
    
    // MARK: - Components
    
    private var container: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 12
        
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    private var containerDay: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 30
        return stackView
    }()
    
    private var lblDay: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .Label.MidWhite.value
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private let imageViewWeatherIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    private var lblMinMaxTemperature: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .Label.Default.value
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Init View
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .default
        accessoryType = .none
        
        addViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - SetUI
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setContainer()
        setcontainerDayComponents()
        
        contentView.backgroundColor = .Background.DarkBlue.value
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        lblDay.text = nil
        lblMinMaxTemperature.text = nil
        imageViewWeatherIcon.image = nil
    }
}

// MARK: - Configure

extension DailyForecastTVCell {
    
    func configure(with model: DailyForecast) {
        lblDay.text = model.day
        lblMinMaxTemperature.text = model.temperatureRange
        
        if let url = URL(string: model.icon) {
            DispatchQueue.global(qos: .userInteractive).async { [weak self] in
                self?.retrieveAndSetImage(for: url)
            }
        }
    }
    
    private func retrieveAndSetImage(for url: URL) {
        let imageDownloader = ImageDownloader(
            configuration: ImageDownloader.defaultURLSessionConfiguration(),
            downloadPrioritization: .fifo,
            maximumActiveDownloads: 4,
            imageCache: AutoPurgingImageCache()
        )
        
        let urlRequest = URLRequest(url: url)

        imageDownloader.download(urlRequest, completion:  { response in
            if case .success(let image) = response.result {
                DispatchQueue.main.async { [weak self] in
                    self?.imageViewWeatherIcon.image = image
                }
            }
        })
    }
}

// MARK: - SetUI

extension DailyForecastTVCell {
    
    private func addViews() {
        contentView.addSubview(container)
        container.addArrangedSubview(containerDay)
        containerDay.addArrangedSubview(lblDay)
        containerDay.addArrangedSubview(imageViewWeatherIcon)
        container.addArrangedSubview(lblMinMaxTemperature)
    }
    
    private func setContainer() {
        let constraintsContainer = [
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            container.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 38),
            container.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
        ]
        NSLayoutConstraint.activate(constraintsContainer)
    }
    
    private func setcontainerDayComponents() {
        lblDay.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.25).isActive = true
        imageViewWeatherIcon.widthAnchor.constraint(equalTo: imageViewWeatherIcon.heightAnchor).isActive = true
    }
}
