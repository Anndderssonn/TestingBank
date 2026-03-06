//
//  OnboardingValidatorTests.swift
//  TestingBankTests
//
//  Created by Andersson on 4/03/26.
//

import XCTest
@testable import TestingBank

@MainActor
final class OnboardingValidatorTests: XCTestCase {
    func test_whenOnboardingCompleted_returnsPassed() async {
        let sut = OnboardingValidator(hasCompletedOnboarding: true)
        let result = await sut.validate()
        XCTAssertEqual(result, .passed)
    }
    
    func test_whenOnboardingNotCompleted_returnsRequiresOnboarding() async {
        let sut = OnboardingValidator(hasCompletedOnboarding: false)
        let result = await sut.validate()
        XCTAssertEqual(result, .failed(.requiresOnBoarding))
    }
}
