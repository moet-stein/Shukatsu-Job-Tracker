//
//  Constants.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 04.05.22.
//

import Foundation
import UIKit

enum JobStatus: String {
    case open = "open"
    case applied = "applied"
    case interview = "interview"
    case closed = "closed"
}

enum Fonts {
    static let latoLight = "Lato-Light"
    static let latoRegular = "Lato-Regular"
    static let latoBold = "Lato-Bold"
    static let latoBlack = "Lato-Black"
}

enum Colors {
    static let skyBlue = UIColor(red: 0.18, green: 0.64, blue: 1.00, alpha: 1.00)
    static let bgOffwhite = UIColor(red: 1.00, green: 0.98, blue: 0.94, alpha: 1.00)
    static let blueGrey = UIColor(red: 0.57, green: 0.66, blue: 0.74, alpha: 1.00)
    static let lightGreen = UIColor(red: 0.40, green: 0.76, blue: 0.55, alpha: 1.00)
    static let lightOrange = UIColor(red: 0.98, green: 0.89, blue: 0.78, alpha: 1.00)
    static let softBrown = UIColor(red: 0.56, green: 0.50, blue: 0.42, alpha: 1.00)
    static let viewOrange = UIColor(red: 1.00, green: 0.53, blue: 0.37, alpha: 1.00)
}

enum UIUserInterfaceIdiom : Int {
    case unspecified
    case phone // iPhone and iPod touch style UI
    case pad   // iPad style UI (also includes macOS Catalyst)
}

enum SaveError: Error {
    case companyNameLocationEmpty
    case companyNameEmpty
    case locationEmpty
}
