//
//  JobInfoDataManagerTests.swift
//  ShukatsuTrackerTests
//
//  Created by Moe Steinmueller on 10.06.22.
//

import XCTest
@testable import Shukatsu_Tracker

class JobInfoDataManagerTests: XCTestCase {
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
    
    func testAddJobInfo() {
        let jobInfo: () = jobInfoDataManager.createJobInfo(delegate: nil, companyName: "Google", location: "Berlin", status: "open", favorite: false, role: "iOS engineer", team: nil, link: nil, notes: nil, appliedDate: nil, lastUpdate: Date())
        
        XCTAssertNotNil(jobInfo, "JobInfo should not be nil")
    }
    
    func testDeleteReport() {
        jobInfoDataManager.createJobInfo(delegate: nil, companyName: "Google", location: "Berlin", status: "open", favorite: false, role: "iOS engineer", team: nil, link: nil, notes: nil, appliedDate: nil, lastUpdate: Date())

        jobInfoDataManager.fetchJonInfos { jobs in
            if let jobs = jobs,  let firstJob = jobs.first {
                XCTAssertTrue(jobs.count == 1)
                jobInfoDataManager.deleteJobInfo(job: firstJob)
            }
        }
        
        jobInfoDataManager.fetchJonInfos { jobs in
            if let jobs = jobs {
                XCTAssertTrue(jobs.isEmpty)
            }
        }
      }
}
