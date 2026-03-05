//
//  MockSessionRepository.swift
//  TestingBankTests
//
//  Created by Andersson on 4/03/26.
//

@testable import TestingBank

class MockSessionRepository: SessionRepositoryProtocol {
    var stateToReturn: SessionState = .notFound
    var errorToThrow: Error?
    var fetchSessionWasCalled = false
    
    func fetchCurrentSession() async throws -> SessionState {
        fetchSessionWasCalled = true
        if let error = errorToThrow {
            throw error
        }
        return stateToReturn
    }
}
