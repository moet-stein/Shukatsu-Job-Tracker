//
//  JobInfoViewModel.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 08.06.22.
//

import Foundation
import UIKit

struct JobInfoViewModel {
    var jobInfo: JobInfo
    var companyName: String
    var location: String
    var locationLabelText: String
    var status: String
    var statusRoundedViewBgColor: UIColor
    var favorite: Bool
    var role: String?
    var team: String?
    var link: String?
    var notes: String?
    var appliedDate: Date?
    var appliedDateString: String?
    var lastUpdate: Date
    var lastUpdateString: String
    var id: UUID
    
    init(jobInfo: JobInfo) {
        self.jobInfo = jobInfo
        self.companyName = jobInfo.companyName
        self.location = jobInfo.location
        self.locationLabelText = "📍\(jobInfo.location)"
        
        self.status = jobInfo.status
        
        let jobStatus = JobStatus(rawValue: jobInfo.status)
        
        self.statusRoundedViewBgColor = {
            switch jobStatus {
            case .open:
                return Colors.skyBlue
            case .applied:
                return Colors.lightGreen
            case .interview:
                return Colors.viewOrange
            case .closed:
                return Colors.blueGrey
            case .none:
                return Colors.blueGrey
            }
        }()
        
        
        
        self.favorite = jobInfo.favorite
        self.role = jobInfo.role
        self.team = jobInfo.team
        self.link = jobInfo.link
        self.notes = jobInfo.notes
        self.appliedDate = jobInfo.appliedDate
        self.appliedDateString = jobInfo.appliedDateString
        self.lastUpdate = jobInfo.lastUpdate
        self.lastUpdateString = jobInfo.lastUpdateString
        self.id = jobInfo.id
    }
}
