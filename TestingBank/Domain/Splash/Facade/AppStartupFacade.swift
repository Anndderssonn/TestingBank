//
//  AppStartupFacade.swift
//  TestingBank
//
//  Created by Andersson on 1/03/26.
//

import Foundation

struct AppStartupFacade {
    private let validators: [any StartupValidatorProtocol]
    
    init(validators: [any StartupValidatorProtocol]) {
        self.validators = validators
    }
    
    func startUp() async -> StartupResultModel {
        for validator in validators {
            let result = await validator.validate()
            if case .failed(let startupResult) = result {
                return startupResult
            }
        }
        return .readyForHome
    }
}
