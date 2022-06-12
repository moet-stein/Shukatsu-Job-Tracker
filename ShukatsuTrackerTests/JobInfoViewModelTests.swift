//
//  JobInfoViewModelTests.swift
//  ShukatsuTrackerTests
//
//  Created by Moe Steinmueller on 12.06.22.
//

import XCTest
@testable import Shukatsu_Tracker

class JobInfoViewModelTests: XCTestCase {

    var jobInfoDataManager: JobInfoDataManager!
    var coreDataStack: CoreDataStack!

    override func setUp() {
      super.setUp()
      coreDataStack = TestCoreDataStack()
        jobInfoDataManager = JobInfoDataManager(
        managedObjectContext: coreDataStack.mainContext,
        coreDataStack: coreDataStack)
    }

    override func tearDown() {
      super.tearDown()
      jobInfoDataManager = nil
      coreDataStack = nil
    }

}
