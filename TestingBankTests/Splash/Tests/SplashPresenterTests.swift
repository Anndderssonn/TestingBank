//
//  SplashPresenterTests.swift
//  TestingBankTests
//
//  Created by Andersson on 4/03/26.
//

import XCTest
@testable import TestingBank

@MainActor
final class SplashPresenterTests: XCTestCase {
    var mockView: MockSplashView!
    var mockInteractor: MockSplashInteractor!
    var mockRouter: MockSplashRouter!
    var sut: SplashPresenter!
    
    override func setUp() {
        super.setUp()
        mockView = MockSplashView()
        mockInteractor = MockSplashInteractor()
        mockRouter = MockSplashRouter()
        sut = SplashPresenter()
        sut.view = mockView
        sut.interactor = mockInteractor
        sut.router = mockRouter
    }
    
    override func tearDown() {
        mockView = nil
        mockInteractor = nil
        mockRouter = nil
        sut = nil
        super.tearDown()
    }
    
    func test_whenViewDidAppear_showsLoadingAndStartsUp() {
        sut.viewDidAppear()
        XCTAssertTrue(mockView.showLoadingWasCalled)
        XCTAssertTrue(mockInteractor.startUpWasCalled)
    }
    
    func test_whenReadyForHome_navigatesToHomeLoggedIn() {
        sut.startUpCompleted(result: .readyForHome)
        XCTAssertTrue(mockRouter.navigateToHomeLoggedInWasCalled)
    }
    
    func test_whenReadyForGuest_navigatesToHomeGuest() {
        sut.startUpCompleted(result: .readyForGuest)
        XCTAssertTrue(mockRouter.navigateToHomeGuestWasCalled)
    }
    
    func test_whenRequiresOnboarding_navigatesToOnboarding() {
        sut.startUpCompleted(result: .requiresOnBoarding)
        XCTAssertTrue(mockRouter.navigateToOnboardingWasCalled)
    }
    
    func test_whenBlocked_navigatesToBlockedWithCorrectReason() {
        sut.startUpCompleted(result: .blocked(.jailBreak))
        XCTAssertTrue(mockRouter.navigateToBlockedWasCalled)
        XCTAssertEqual(mockRouter.blockReasonReceived, .jailBreak)
    }
    
    func test_whenBlocked_doesNotNavigateElsewhere() {
        sut.startUpCompleted(result: .blocked(.maintenanceMode))
        XCTAssertFalse(mockRouter.navigateToHomeLoggedInWasCalled)
        XCTAssertFalse(mockRouter.navigateToHomeGuestWasCalled)
        XCTAssertFalse(mockRouter.navigateToOnboardingWasCalled)
    }
}
