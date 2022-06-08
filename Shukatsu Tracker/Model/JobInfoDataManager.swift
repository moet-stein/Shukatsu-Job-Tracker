//
//  CoreDataManager.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 22.04.22.
//

import Foundation
import CoreData
import UIKit

class JobInfoDataManager {
    static let managedObjectContext: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }()
    
    // MARK: - Create
    static func createJobInfo(delegate: HomeVCDelegate?,
                                   companyName: String,
                                   location: String,
                                   status: String,
                                   favorite: Bool,
                                   role: String?,
                                   team: String?,
                                   link: String?,
                                   notes: String?,
                                   appliedDate: Date?,
                                   lastUpdate: Date) {
        
        let jobInfo = JobInfo(context: managedObjectContext)
        jobInfo.setValue(companyName, forKey: "companyName")
        jobInfo.setValue(location, forKey: "location")
        jobInfo.setValue(status, forKey: "status")
        jobInfo.setValue(favorite, forKey: "favorite")
        jobInfo.setValue(role, forKey: "role")
        jobInfo.setValue(team, forKey: "team")
        jobInfo.setValue(link, forKey: "link")
        jobInfo.setValue(notes, forKey: "notes")
        jobInfo.setValue(appliedDate, forKey: "appliedDate")
        jobInfo.setValue(lastUpdate, forKey: "lastUpdate")
        jobInfo.setValue(UUID(), forKey: "id")
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd, EEE"
        
        if let appliedDate = appliedDate {
            let dateString = formatter.string(from: appliedDate)
            jobInfo.setValue(dateString, forKey: "appliedDateString")
        }
        
        let lastUpdateString = formatter.string(from: lastUpdate)
        jobInfo.setValue(lastUpdateString, forKey: "lastUpdateString")
        
        do {
            try managedObjectContext.save()
            delegate?.fetchJobInfosAndReload()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    // MARK: - Read
    
    static func fetchJonInfos(completion: ([JobInfo]?) -> Void) {
        do {
            let jobInfos = try managedObjectContext.fetch(JobInfo.createFetchRequest())
            completion(jobInfos)
        } catch {
            print("Fetch JobInfos failed")
        }
        
        completion(nil)
    }
    
    static func fetchJobInfo(usingId id: UUID, completion: (JobInfo?) -> Void) {
        let fetchRequest = NSFetchRequest<JobInfo>(entityName: "JobInfo")
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            let jobInfo = try managedObjectContext.fetch(fetchRequest)
            completion(jobInfo.first)
        } catch {
            print("Could not fetch due to error: \(error.localizedDescription)")
        }
        
        completion(nil)
    }
    
    // MARK: - Update
    static func updateJobInfo(detailsVCdelegate: DetailsVCDelegate?, job: JobInfo,companyName: String, location: String, status: String, favorite: Bool, role: String?, team: String?, link: String?, notes: String?, appliedDate: Date?, lastUpdate: Date) {

        job.companyName = companyName
        job.location = location
        job.status = status
        job.role = role
        job.team = team
        job.link = link
        job.notes = notes
        job.favorite = favorite
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd, EEE"
        
        if let appliedDate = appliedDate {
            let dateString = formatter.string(from: appliedDate)
            job.appliedDate = appliedDate
            job.appliedDateString = dateString
        }
        
        let lastUpdateString = formatter.string(from: lastUpdate)
        job.lastUpdate = lastUpdate
        job.lastUpdateString = lastUpdateString
        
        do {
            try managedObjectContext.save()
            detailsVCdelegate?.updateJobInfoInDetailsVC(jobInfo: JobInfoViewModel(jobInfo: job))
            
        } catch let error as NSError {
            print("Could not update. \(error), \(error.userInfo)")
        }
    }
    
    static func updateFavorite(job: JobInfo, favorite: Bool) {
        job.favorite = favorite
        
        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            print("Could not update. \(error), \(error.userInfo)")
        }
    }
    
    
    // MARK: - Delete
    static func deleteJobInfo(job: JobInfo) {
        managedObjectContext.delete(job)
        
        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            print("Could not update. \(error), \(error.userInfo)")
        }
    }
    
    
}
