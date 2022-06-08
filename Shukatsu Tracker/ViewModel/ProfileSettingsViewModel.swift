//
//  ProfileSettingsViewModel.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 08.06.22.
//

import Foundation
import UIKit

struct ProfileSettingsViewModel {
    let profileSettings: ProfileSettings
    let profileNameLabelString: String
    let profileTitleLabelString: String
    let profileImage: UIImage
    let profilePinOn: Bool
    
    init(profileSettings: ProfileSettings) {
        self.profileSettings = profileSettings
        if let name = profileSettings.profileName {
            self.profileNameLabelString = "Hello, \(name)"
        } else {
            self.profileNameLabelString = "Hello, unknown"
        }
        
        if let title = profileSettings.profileTitle {
            self.profileTitleLabelString = title
        } else {
            self.profileTitleLabelString = "unknown title"
        }
        
        if let image = profileSettings.profileImage {
            self.profileImage = UIImage(data: image)!
        } else {
            self.profileImage = UIImage(named: "azuImage")!
        }
        
        self.profilePinOn = profileSettings.pinOn
        
    }
}
