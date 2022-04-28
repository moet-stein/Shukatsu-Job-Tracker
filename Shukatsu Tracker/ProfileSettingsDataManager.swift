//
//  ProfileSettingsDataManager.swift
//  Shukatsu Tracker
//
//  Created by Moe Steinmueller on 28.04.22.
//

import Foundation
import CoreData
import UIKit

class ProfileSettingsDataManager {
    static let managedObjectContext: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }()
    
    // MARK: - Create
    static func createProfileSettings(profileName: String, profileTitle: String, pinOn: Bool) {
        
        let profileSettings = ProfileSettings(context: managedObjectContext)
        profileSettings.setValue(profileName, forKey: "profileName")
        profileSettings.setValue(profileTitle, forKey: "profileTitle")
        profileSettings.setValue(pinOn, forKey: "pinOn")

        do {
            try managedObjectContext.save()
//            delegate?.fetchJobInfosAndReload()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    // MARK: - Read
    
    static func fetchProfileSettings(completion: ([ProfileSettings]?) -> Void) {
        do {
            let profile = try managedObjectContext.fetch(ProfileSettings.fetchRequest())
            completion(profile)
        } catch {
            print("Fetch ProfileSettings failed")
        }
        
        completion(nil)
    }
    
//    static func fetchJobInfo(usingId id: UUID, completion: (JobInfo?) -> Void) {
//        let fetchRequest = NSFetchRequest<JobInfo>(entityName: "JobInfo")
//        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
//
//        do {
//            let jobInfo = try managedObjectContext.fetch(fetchRequest)
//            completion(jobInfo.first)
//        } catch {
//            print("Could not fetch due to error: \(error.localizedDescription)")
//        }
//
//        completion(nil)
//    }
    
    // MARK: - Update
    static func updateProfileSettings(profileSettings: ProfileSettings, profileName: String?, profileTitle: String?, pinOn: Bool?) {
        
        if let name = profileName {
            profileSettings.profileName = name
        }
        
        if let title = profileTitle {
            profileSettings.profileTitle = title
        }
        
        if let pinOn = pinOn {
            profileSettings.pinOn = pinOn
        }
        
        do {
            try managedObjectContext.save()
//            detailsVCdelegate?.updateJobInfoInDetailsVC(jobInfo: job)
            
        } catch let error as NSError {
            print("Could not update. \(error), \(error.userInfo)")
        }
        
    }
    
    
    // MARK: - Delete
//    static func deleteJobInfo(job: JobInfo) {
//        managedObjectContext.delete(job)
//
//        do {
//            try managedObjectContext.save()
//        } catch let error as NSError {
//            print("Could not update. \(error), \(error.userInfo)")
//        }
//    }
    
    
}

