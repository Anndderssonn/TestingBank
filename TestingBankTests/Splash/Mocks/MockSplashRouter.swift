//
//  MockSplashRouter.swift
//  TestingBankTests
//
//  Created by Andersson on 4/03/26.
//

@testable import TestingBank

class MockSplashRouter: SplashRouterDelegate {
    var navigateToHomeLoggedInWasCalled = false
    var navigateToHomeGuestWasCalled = false
    var navigateToOnboardingWasCalled = false
    var navigateToBlockedWasCalled = false
    var blockReasonReceived: BlockReasonModel?
    
    func navigateToHomeLoggedIn() {
        navigateToHomeLoggedInWasCalled = true
    }
    
    func navigateToHomeGuest() {
        navigateToHomeGuestWasCalled = true
    }
    
    func navigateToOnBoarding() {
        navigateToOnboardingWasCalled = true
    }
    
    func navigateToBlocked(reason: BlockReasonModel) {
        navigateToBlockedWasCalled = true
        blockReasonReceived = reason
    }
}
