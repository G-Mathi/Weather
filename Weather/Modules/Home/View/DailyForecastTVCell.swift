//
//  DailyForecastTVCell.swift
//  Weather
//
//  Created by dilax on 2023-02-20.
//

import UIKit

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
        
//        stackView.backgroundColor = .yellow
        return stackView
    }()
    
    private var lblDay: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16)
        
        label.backgroundColor = .green
        return label
    }()
    
    /// Temperatire Min Max View
    private var containerMinMax: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 12
        
        stackView.backgroundColor = .white
        return stackView
    }()
    
    private var lblMinTemperature: UILabel = {
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
    
    private var lblMaxTemperature: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    // MARK: - Init View
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .default
        accessoryType = .none
        
        addViews()
        addMinMaxViews()
        
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
    }
}

// MARK: - Set UI

extension DailyForecastTVCell {
    
    private func addViews() {
        contentView.addSubview(container)
        container.addArrangedSubview(lblDay)
//        container.addArrangedSubview(UIView())
        container.addArrangedSubview(containerMinMax)
    }
    
    // MARK: - Configure
    
    func configure() {
        lblDay.text = "Monday"
        configureMinMaxView()
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
    
    // MARK: - Configure MinMaxView
    
    func configureMinMaxView() {
        lblMinTemperature.text = 28.0.convertTemperature(from: .kelvin, to: .celsius)
        progressBar.progress = 0.65
        lblMaxTemperature.text = 33.0.convertTemperature(from: .kelvin, to: .celsius)
    }
}
