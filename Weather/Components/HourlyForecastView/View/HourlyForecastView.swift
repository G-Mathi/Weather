//
//  HourlyForecastView.swift
//  Weather
//
//  Created by Mathi on 2023-02-19.
//

import UIKit

class HourlyForecastView: UIView {
    
    // MARK: - Variables
    
    private var vm = HourlyForecastVM()
    
    // MARK: Components
    
    private var hourlyForecastView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .link
        return collectionView
    }()
    
    // MARK: - Init View
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(hourlyForecastView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError()
    }
    
    // MARK: - SetUI
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setHourlyForecastView()
    }
}

// MARK: - Configure

extension HourlyForecastView {
    
    func configure(with hourlyWeatherInfo: [HourlyForecast]) {
        vm.hourlyWeatherInfo = hourlyWeatherInfo
        
        DispatchQueue.main.async { [weak self] in
            self?.hourlyForecastView.reloadData()
        }
    }
}

// MARK: - Set Hourly View

extension HourlyForecastView {
    
    private func setHourlyForecastView() {
        hourlyForecastView.delegate = self
        hourlyForecastView.dataSource = self
        hourlyForecastView.register(HourlyForecastCVCell.self, forCellWithReuseIdentifier: HourlyForecastCVCell.identifier)
        
        let constraintsHourlyView = [
            hourlyForecastView.topAnchor.constraint(equalTo: self.topAnchor),
            hourlyForecastView.leftAnchor.constraint(equalTo: self.leftAnchor),
            hourlyForecastView.rightAnchor.constraint(equalTo: self.rightAnchor),
            hourlyForecastView.heightAnchor.constraint(equalToConstant: 90)
        ]
        NSLayoutConstraint.activate(constraintsHourlyView)
    }
}

// MARK: - CollectionView Delegate

extension HourlyForecastView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.getWeatherDataCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let hourlyForeCastCVCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HourlyForecastCVCell.identifier,
            for: indexPath) as? HourlyForecastCVCell {
            
            hourlyForeCastCVCell.configure(with: vm.getWeatherInfo(at: indexPath.row))
            
            return hourlyForeCastCVCell
        }
        
        return UICollectionViewCell()
    }
}

// MARK: - CollectionView FlowLayout

extension HourlyForecastView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = 60
        let height = 80
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
}
