//
//  Jobs.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 07.04.22.
//

import Foundation

class Jobs {
    let jobs = [
        Job(companyName: "PayPal", location: "Remote", status: "interview", favorite: true, role: nil, team: nil, link: nil, notes: nil, appliedDateString: "2022/04/02", lastUpdate: Date()),
        Job(companyName: "Intuit", location: "San Diego", status: "applied", favorite: true, role: nil, team: nil, link: nil, notes: nil, appliedDateString: "2022/04/12", lastUpdate: Date()),
        Job(companyName: "Apple", location: "New York", status: "applied", favorite: false, role: nil, team: nil, link: nil, notes: nil, appliedDateString: "2022/04/01", lastUpdate: Date()),
        Job(companyName: "Nike", location: "Portland", status: "open", favorite: false, role: nil, team: nil, link: nil, notes: nil, appliedDateString: "2022/03/31", lastUpdate: Date()),
        Job(companyName: "Patreon", location: "San Francisco", status: "open", favorite: true, role: nil, team: nil, link: nil, notes: nil, appliedDateString: "2022/03/31", lastUpdate: Date()),
        Job(companyName: "VMWare", location: "Remote", status: "closed", favorite: false, role: nil, team: nil, link: nil, notes: nil, appliedDateString: "2022/04/01", lastUpdate: Date()),
        Job(companyName: "Google", location: "Mountain View", status: "applied", favorite: true, role: nil, team: nil, link: nil, notes: nil, appliedDateString: "2022/05/02", lastUpdate: Date()),
        Job(companyName: "Fitbit", location: "San Francisco", status: "interview", favorite: false, role: nil, team: nil, link: nil, notes: nil, appliedDateString: "2022/05/02", lastUpdate: Date()),
        Job(companyName: "Mailchimp", location: "Atlanta", status: "closed", favorite: true, role: nil, team: nil, link: nil, notes: nil, appliedDateString: "2022/03/02", lastUpdate: Date()),
        Job(companyName: "Pixar", location: "Emeryville", status: "interview", favorite: false, role: nil, team: nil, link: nil, notes: nil, appliedDateString: "2022/03/02", lastUpdate: Date()),
        Job(companyName: "Disney", location: "Anaheim", status: "applied", favorite: false, role: nil, team: nil, link: nil, notes: nil, appliedDateString: "2022/03/02", lastUpdate: Date()),
        Job(companyName: "Sporify", location: "New York", status: "interview", favorite: true, role: nil, team: nil, link: nil, notes: nil, appliedDateString: "2022/05/02", lastUpdate: Date())
    ]
}

struct Job {
    var companyName: String
    var location: String?
    var status: String
    var favorite: Bool
    var role: String?
    var team: String?
    var link: String?
    var notes: String?
    var appliedDateString: String
    var appliedDate: Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter.date(from: "appliedDateString") ?? Date()
    }
    var lastUpdate: Date
    
}
