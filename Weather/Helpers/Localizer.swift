//
//  Localizer.swift
//  Weather
//
//  Created by Mathi on 2023-02-24.
//

import Foundation

extension String {
    var localizedString: String {
        return NSLocalizedString(self, comment: "")
    }
    
    static let Alert =  NSLocalizedString("Alert", comment: "")
    static let Okay = NSLocalizedString("Okay", comment: "")
    static let Cancel = NSLocalizedString("Cancel", comment: "")
    static let Done = NSLocalizedString("Done", comment: "")
    static let Confirm = NSLocalizedString("Confirm", comment: "")
    static let Dismiss = NSLocalizedString("Dismiss", comment: "")
    static let Sorry = NSLocalizedString("Sorry...", comment: "")
    
    static let LocationDeniedTitle = NSLocalizedString("Location settings turned off", comment: "")
    static let LocationRestricted = NSLocalizedString("Sorry, your location is restricted for our use", comment: "")
    static let LocationDenied = NSLocalizedString("Please turn on your location settings in Weather", comment: "")
}
