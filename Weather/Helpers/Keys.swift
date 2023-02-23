//
//  Keys.swift
//  Weather
//
//  Created by Mathi on 2023-02-24.
//

import Foundation

protocol Keyable {
    var Weather_API_Key: String { get }
}

class Keys: Keyable {
    let dict: NSDictionary
    
    init(resourceName: String) {
        guard let filePath = Bundle.main.path(forResource: resourceName, ofType: "plist"),
              let plist = NSDictionary(contentsOfFile: filePath)
        else {
            fatalError("Couldn't find the file")
        }
        self.dict = plist
    }
    
    var Weather_API_Key: String {
        dict.object(forKey: "WeatherAPIKey") as? String ?? ""
    }
}
