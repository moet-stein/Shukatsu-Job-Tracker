//
//  TestCoreDataStack.swift
//  ShukatsuTrackerTests
//
//  Created by Moe Steinmueller on 12.06.22.
//

import XCTest
import CoreData
import Shukatsu_Tracker

class TestCoreDataStack: CoreDataStack {
    override init() {
        super.init()
        
        // 1
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        
        // 2
        let container = NSPersistentContainer(
            name: CoreDataStack.modelName,
            managedObjectModel: CoreDataStack.model)
        
        // 3
        container.persistentStoreDescriptions = [persistentStoreDescription]
        
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        // 4
        storeContainer = container
    }
    
}
