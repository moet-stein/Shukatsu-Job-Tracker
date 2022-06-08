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
    let profileNameString: String
    let profileNameLabelString: String
    let profileTitleLabelString: String
    let profileImage: UIImage
    let profilePinOn: Bool
    
    init(profileSettings: ProfileSettings) {
        self.profileSettings = profileSettings
        
        if let name = profileSettings.profileName {
            if !name.isEmpty {
                self.profileNameString = name
                self.profileNameLabelString = "Hello, \(name)"
            } else {
                self.profileNameString = "unknown"
                self.profileNameLabelString = "Hello, unknown"
            }
        } else {
            self.profileNameString = "unknown"
            self.profileNameLabelString = "Hello, unknown"
        }
        
        if let title = profileSettings.profileTitle {
            if !title.isEmpty {
                self.profileTitleLabelString = title
            } else {
                self.profileTitleLabelString = "unknown title"
            }
        } else {
            self.profileTitleLabelString = "unknown title"
        }
        
        if let image = profileSettings.profileImage {
            if !image.isEmpty {
                self.profileImage = UIImage(data: image)!
            } else {
                self.profileImage = UIImage(named: "azuImage")!
            }
        } else {
            self.profileImage = UIImage(named: "azuImage")!
        }
        
        self.profilePinOn = profileSettings.pinOn
        
    }
}
