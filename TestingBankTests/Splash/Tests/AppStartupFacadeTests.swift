//
//  AppStartupFacadeTests.swift
//  TestingBankTests
//
//  Created by Andersson on 4/03/26.
//

import XCTest
@testable import TestingBank

@MainActor
final class AppStartupFacadeTests: XCTestCase {
    var validatorOne: MockStartUpValidator!
    var validatorTwo: MockStartUpValidator!
    var validatorThree: MockStartUpValidator!
    var sut: AppStartupFacade!
    
    override func setUp() {
        super.setUp()
        validatorOne = MockStartUpValidator()
        validatorTwo = MockStartUpValidator()
        validatorThree = MockStartUpValidator()
    }
    
    override func tearDown() {
        validatorOne = nil
        validatorTwo = nil
        validatorThree = nil
        sut = nil
        super.tearDown()
    }
    
    func test_whenAllValidatorsPass_returnReadyForHome() async {
        validatorOne.resultToReturn = .passed
        validatorTwo.resultToReturn = .passed
        validatorThree.resultToReturn = .passed
        
        sut = AppStartupFacade(validators: [
            validatorOne,
            validatorTwo,
            validatorThree
        ])
        
        let result = await sut.startUp()
        XCTAssertEqual(result, .readyForHome)
    }
    
    func test_WhenFirstValidatorFails_stopsExecutation() async {
        validatorOne.resultToReturn = .failed(.blocked(.jailBreak))
        validatorTwo.resultToReturn = .passed
        validatorThree.resultToReturn = .passed
        
        sut = AppStartupFacade(validators: [
            validatorOne,
            validatorTwo,
            validatorThree
        ])
        
        let result = await sut.startUp()
        XCTAssertEqual(result, .blocked(.jailBreak))
        XCTAssertEqual(validatorTwo.validateCallCount, 0)
        XCTAssertEqual(validatorThree.validateCallCount, 0)
    }
    
    func test_WhenSecondValidatorFails_stopsExecutation() async {
        validatorOne.resultToReturn = .passed
        validatorTwo.resultToReturn = .failed(.readyForGuest)
        validatorThree.resultToReturn = .passed
        
        sut = AppStartupFacade(validators: [
            validatorOne,
            validatorTwo,
            validatorThree
        ])
        
        let result = await sut.startUp()
        XCTAssertEqual(result, .readyForGuest)
        XCTAssertEqual(validatorThree.validateCallCount, 0)
    }
    
    func test_WhenNoValidators_returnsReadyForHOme() async {
        sut = AppStartupFacade(validators: [])
        let result = await sut.startUp()
        XCTAssertEqual(result, .readyForHome)
    }
}
