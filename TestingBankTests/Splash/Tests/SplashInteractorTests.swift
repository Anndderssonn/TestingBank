//
//  SplashInteractorTests.swift
//  TestingBankTests
//
//  Created by Andersson on 4/03/26.
//

import XCTest
@testable import TestingBank

@MainActor
final class SplashInteractorTests: XCTestCase {
    var mockPresenter: MockSplashPresenter!
    var sut: SplashInteractor!
    
    override func setUp() {
        super.setUp()
        mockPresenter = MockSplashPresenter()
    }
    
    override func tearDown() {
        mockPresenter = nil
        sut = nil
        super.tearDown()
    }
    
    func test_whenStartUpReturnsReadyForHome_notifiesPresenter() async {
        let validator = MockStartUpValidator()
        validator.resultToReturn = .passed
        let facade = AppStartupFacade(validators: [validator])
        sut = SplashInteractor(facade: facade)
        sut.presenter = mockPresenter
        await sut.performStartUp()
        XCTAssertTrue(mockPresenter.startUpCompletedWasCalled)
        XCTAssertEqual(mockPresenter.resultReceived, .readyForHome)
    }
    
    func test_whenStartUpReturnsReadyForGuest_notifiesPresenter() async {
        let validator = MockStartUpValidator()
        validator.resultToReturn = .failed(.readyForGuest)
        let facade = AppStartupFacade(validators: [validator])
        sut = SplashInteractor(facade: facade)
        sut.presenter = mockPresenter
        await sut.performStartUp()
        XCTAssertTrue(mockPresenter.startUpCompletedWasCalled)
        XCTAssertEqual(mockPresenter.resultReceived, .readyForGuest)
    }
    
    func test_whenNoPresenter_doesNotCrash() async {
        let facade = AppStartupFacade(validators: [])
        sut = SplashInteractor(facade: facade)
        sut.presenter = nil
        await sut.performStartUp()
        XCTAssertFalse(mockPresenter.startUpCompletedWasCalled)
    }
}
