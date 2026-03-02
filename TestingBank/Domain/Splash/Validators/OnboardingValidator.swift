//
//  OnboardingValidator.swift
//  TestingBank
//
//  Created by Andersson on 1/03/26.
//

import Foundation

struct OnboardingValidator: StartupValidatorProtocol {
    private let hasCompleteOnboarding: Bool
    
    init(hasCompleteOnboarding: Bool) {
        self.hasCompleteOnboarding = hasCompleteOnboarding
    }
    
    func validate() async -> ValidationResultModel {
        return hasCompleteOnboarding ? .passed : .failed(.requiresOnBoarding)
    }
}
