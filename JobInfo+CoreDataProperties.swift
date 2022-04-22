//
//  JobInfo+CoreDataProperties.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 19.04.22.
//
//

import Foundation
import CoreData


extension JobInfo {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<JobInfo> {
        return NSFetchRequest<JobInfo>(entityName: "JobInfo")
    }

    @NSManaged public var companyName: String
    @NSManaged public var location: String?
    @NSManaged public var status: String?
    @NSManaged public var favorite: Bool
    @NSManaged public var role: String?
    @NSManaged public var team: String?
    @NSManaged public var link: String?
    @NSManaged public var notes: String?
    @NSManaged public var appliedDate: Date?
    @NSManaged public var appliedDateString: String?
    @NSManaged public var lastUpdate: Date
    @NSManaged public var lastUpdateString: String
    @NSManaged public var id: UUID

}

extension JobInfo : Identifiable {

}
