//
//  DailyForecastTVCell.swift
//  Weather
//
//  Created by Mathi on 2023-02-20.
//

import UIKit

struct DailyForecast {
    var day: String = ""
    var icon: String = ""
    var minTemperature: String = ""
    var maxTemperature: String = ""
}

class DailyForecastTVCell: UITableViewCell {
    static let identifier = "DailyForecastTVCell"
    
    // MARK: - Components
    
    private var container: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 12
        
        #warning("Remove")
        stackView.backgroundColor = .yellow
        return stackView
    }()
    
    private var lblDay: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16)
        
        #warning("Remove")
        label.backgroundColor = .green
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
    
    /// Temperatire Min Max View
    private var containerMinMax: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 12
        
        #warning("Remove")
        stackView.backgroundColor = .white
        return stackView
    }()
    
    private var lblMinTemperature: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private var lblMaxTemperature: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private var progressBar: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.progress = 0
        progressView.progressTintColor = .green
        progressView.trackTintColor = .red
        return progressView
    }()
    
    // MARK: - Init View
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .default
        accessoryType = .none
        
        addViews()
        addMinMaxViews()
        
        #warning("Remove")
        contentView.backgroundColor = .link
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - SetUI
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setMinMaxView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        lblDay.text = nil
        lblMinTemperature.text = nil
        lblMaxTemperature.text = nil
        imageViewWeatherIcon.image = nil
    }
}

// MARK: - Configure

extension DailyForecastTVCell {
    
    func configure(with model: DailyForecast) {
        lblDay.text = model.day
        lblMinTemperature.text = model.minTemperature
        lblMaxTemperature.text = model.maxTemperature
        imageViewWeatherIcon.image = UIImage(systemName: "person")
        progressBar.progress = 0.6
    }
}

// MARK: - SetUI

extension DailyForecastTVCell {
    
    private func addViews() {
        contentView.addSubview(container)
        container.addArrangedSubview(lblDay)
        container.addArrangedSubview(containerMinMax)
    }
}

// MARK: - Set MinMax View

extension DailyForecastTVCell {
    
    private func setMinMaxView() {
        progressBar.widthAnchor.constraint(equalToConstant: 120).isActive = true
    }
    
    private func addMinMaxViews() {
        containerMinMax.addArrangedSubview(lblMinTemperature)
        containerMinMax.addArrangedSubview(progressBar)
        containerMinMax.addArrangedSubview(lblMaxTemperature)
    }
}
