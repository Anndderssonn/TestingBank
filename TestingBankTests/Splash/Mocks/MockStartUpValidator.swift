//
//  MockStartUpValidator.swift
//  TestingBankTests
//
//  Created by Andersson on 4/03/26.
//

@testable import TestingBank

class MockStartUpValidator: StartupValidatorProtocol {
    var resultToReturn: ValidationResultModel = .passed
    var validateCallCount = 0
    
    func validate() async -> ValidationResultModel {
        validateCallCount += 1
        return resultToReturn
    }
}
