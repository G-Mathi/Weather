//
//  HomeVC.swift
//  Weather
//
//  Created by Mathi on 2023-02-18.
//

import UIKit

class HomeVC: UIViewController {

    // MARK: - Variables
    
    private var vm = HomeVM()
    
    // MARK: Components
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    /// Current Temperature StackView
    private var currentTemperatureView: CurrentTemperatureView = {
        let stackView = CurrentTemperatureView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layer.cornerRadius = 12
        
        stackView.backgroundColor = .orange
        return stackView
    }()
    
    private var collectionView: UICollectionView = {
        let collectionView = UICollectionView()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        configure()
        
        // vm.checkIfLocationServicesEnabled()
    }
    
    // MARK: - SetupUI
    
    private func setupUI() {
        self.title = "Home"
        view.backgroundColor = .systemBackground
        
        setTemperatureView()
    }
    
    // MARK: - Configure
    
    private func configure() {
        
    }
}

// MARK: - Set Temperature View

extension HomeVC {
    
    private func setTemperatureView() {
        view.addSubview(currentTemperatureView)
        
        let safeArea = view.safeAreaLayoutGuide
        let constraintsCurrentTempView = [
            currentTemperatureView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 30),
            currentTemperatureView.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 30),
            currentTemperatureView.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -30)
        ]
        NSLayoutConstraint.activate(constraintsCurrentTempView)
        
        currentTemperatureView.configure()
    }
}
