//
//  MockRemoteConfigDataSource.swift
//  TestingBankTests
//
//  Created by Andersson on 4/03/26.
//

@testable import TestingBank

class MockRemoteConfigDataSource: RemoteConfigDataSourceProtocol {
    var dtoToReturn = RemoteConfigDTO(
        minimumVersion: "1.0.0",
        maintenanceMode: false,
        currentVersion: "2.0.0"
    )
    var errorToThrow: Error?
    var fetchConfigWasCalled = false
    
    func fetchConfig() async throws -> RemoteConfigDTO {
        fetchConfigWasCalled = true
        if let error = errorToThrow {
            throw error
        }
        return dtoToReturn
    }
}
