//
//  OnboardingValidator.swift
//  TestingBank
//
//  Created by Andersson on 1/03/26.
//

import Foundation

struct OnboardingValidator: StartupValidatorProtocol {
    private let hasCompletedOnboarding: Bool
    
    init(hasCompletedOnboarding: Bool) {
        self.hasCompletedOnboarding = hasCompletedOnboarding
    }
    
    func validate() async -> ValidationResultModel {
        return hasCompletedOnboarding ? .passed : .failed(.requiresOnBoarding)
    }
}
