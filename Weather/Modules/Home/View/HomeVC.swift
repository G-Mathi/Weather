//
//  HomeVC.swift
//  Weather
//
//  Created by dilax on 2023-02-18.
//

import UIKit

class HomeVC: UIViewController {

    // MARK: - Variables
    
    private var vm = HomeVM()
    
    // MARK: Components
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        configure()
        
        vm.checkIfLocationServicesEnabled()
    }
    
    // MARK: - SetupUI
    
    private func setupUI() {
        self.title = "Home"
        view.backgroundColor = .systemBackground
    }
    
    // MARK: - Configure
    
    private func configure() {
        
    }
}
