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
    static let skyBlue = UIColor(named: "skyBlue")
    static let bgOffWhite = UIColor(named: "bfOffWhite")
    static let blueGrey = UIColor(named: "blueGrey")
    static let lightGreen = UIColor(named: "lightGreen")
    static let lightOrange = UIColor(named: "lightOrange")
    static let softBrown = UIColor(named: "softBrown")
    static let viewOrange = UIColor(named: "viewOrange")
}
