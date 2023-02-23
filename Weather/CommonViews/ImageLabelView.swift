//
//  ImageLabelView.swift
//  Weather
//
//  Created by Mathi on 2023-02-23.
//

import UIKit

struct ImageLabel {
    var icon: String
    var title: String
}

class ImageLabelView: UIStackView {
    
    private let imageViewIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .Label.Default.value
        label.font = .systemFont(ofSize: 14)
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

extension ImageLabelView {
    
    func configure(with model: ImageLabel) {
        imageViewIcon.image = UIImage(systemName: model.icon)
        label.text = model.title
    }
}

// MARK: - SetUI

extension ImageLabelView {
    
    private func addViews() {
        self.addArrangedSubview(imageViewIcon)
        self.addArrangedSubview(label)
    }
    
    private func setUI() {
        self.axis = .horizontal
        self.alignment = .center
        self.distribution = .fill
        self.spacing = 8
        
        imageViewIcon.widthAnchor.constraint(equalTo: imageViewIcon.heightAnchor, multiplier: 1).isActive = true
    }
}
