//
//  EnterPinViewControllerTests.swift
//  ShukatsuTrackerTests
//
//  Created by Moe Steinmueller on 05.07.22.
//

import XCTest
@testable import Shukatsu_Tracker

class EnterPinViewControllerTests: XCTestCase {
    
    var sut: EnterPinViewController!
    
    override func setUp() {
        sut = EnterPinViewController()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testIsPinMatched_whenIlligalCharacterUsedInPassword_pinShouldMatch() {
        let enteredPin = "1234"
        let storedPin = "1234"
        
        let isPinMatched = sut.isPinMatched(enteredPin: enteredPin, storedPin: storedPin)
        
        XCTAssertTrue(isPinMatched)
    }
    
    func testIsPinMatched_whenIlligalCharacterUsedInPassword_pinShouldNotMatch() {
        let enteredPin = "1234"
        let storedPin = "1233"
        
        let isPinMatched = sut.isPinMatched(enteredPin: enteredPin, storedPin: storedPin)
        
        XCTAssertFalse(isPinMatched)
    }
}
