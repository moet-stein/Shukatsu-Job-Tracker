//
//  EnterPinViewControllerTests.swift
//  ShukatsuTrackerTests
//
//  Created by Moe Steinmueller on 05.07.22.
//

import XCTest
@testable import Shukatsu_Tracker

class EnterPinViewControllerTests: XCTestCase {
    override func setUp() {
        
    }
    
    override func tearDown() {
        
    }
    
    func testIsPinMatched_whenIlligalCharacterUsedInPassword_pinShouldMatch() {
        let enteredPin = "1234"
        let storedPin = "1234"
        
        let sut = EnterPinViewController()
        
        let isPinMatched = sut.isPinMatched(enteredPin: enteredPin, storedPin: storedPin)
        
        XCTAssertTrue(isPinMatched)
    }
}
