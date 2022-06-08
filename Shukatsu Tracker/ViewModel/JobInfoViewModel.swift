//
//  JobInfoViewModel.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 08.06.22.
//

import Foundation

struct JobInfoViewModel {
    let companyName: String
    let location: String
    let status: String
    let favorite: Bool
    let role: String?
    let team: String?
    let link: String?
    let notes: String?
    let appliedDate: Date?
    let appliedDateString: String?
    let lastUpdate: Date
    let lastUpdateString: String
    let id: UUID
    
    init(jobInfo: JobInfo) {
        self.companyName = jobInfo.companyName
        self.location = jobInfo.location
        
        self.status = jobInfo.status
        
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
