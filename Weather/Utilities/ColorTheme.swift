//
//  ColorTheme.swift
//  Weather
//
//  Created by Mathi on 2023-02-24.
//

import UIKit

extension UIColor {
    
    // MARK: - Common
    
    enum Common {
        case AccentColor
        
        var value: UIColor {
            switch self {
            case .AccentColor:
                return UIColor(named: "AccentColor") ?? UIColor.blue
            }
        }
    }
    
    // MARK: - Label
    
    enum Label {
        case Default
        case TimeLabel
        case MidWhite
        
        var value: UIColor {
            switch self {
            case .Default:
                return UIColor(named: "DefaultLabel") ?? UIColor.white
            case .TimeLabel:
                return UIColor(named: "TimeLabel") ?? UIColor.lightGray
            case .MidWhite:
                return UIColor(named: "MidWhite") ?? UIColor.lightGray
            }
        }
    }
    
    // MARK: - Background
    
    enum Background {
        case DarkBlue
        case MidBlue
        
        var value: UIColor {
            switch self {
            case .DarkBlue:
                return UIColor(named: "DarkBlue") ?? UIColor.link
            case .MidBlue:
                return UIColor(named: "MidBlue") ?? UIColor.blue
            }
        }
    }
}

