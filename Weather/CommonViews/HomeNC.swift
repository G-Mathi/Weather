//
//  HomeNC.swift
//  Weather
//
//  Created by Mathi on 2023-02-20.
//

import UIKit

class HomeNC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationController()
    }
    
    private func setNavigationController() {
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithDefaultBackground()
            self.navigationBar.standardAppearance = appearance
            self.navigationBar.scrollEdgeAppearance = appearance
            self.navigationBar.compactAppearance = appearance
        } else {
            
        }
        
        self.navigationBar.prefersLargeTitles = true
    }
}
