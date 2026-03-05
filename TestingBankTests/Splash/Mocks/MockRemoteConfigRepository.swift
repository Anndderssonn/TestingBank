//
//  MockRemoteConfigRepository.swift
//  TestingBankTests
//
//  Created by Andersson on 4/03/26.
//

@testable import TestingBank

class MockRemoteConfigRepository: RemoteConfigRepositoryProtocol {
    var configToReturn: RemoteConfigModel = RemoteConfigModel(
        minimumAppVersion: "1.0.0",
        isMaintenanceModeActive: false,
        currentAppVersion: "2.0.0"
    )
    var errorToThrow: Error?
    var fetchConfigWascalled = false
    
    func fetchConfig() async throws -> RemoteConfigModel {
        fetchConfigWascalled = true
        if let error = errorToThrow {
            throw error
        }
        return configToReturn
    }
}
