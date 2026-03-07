//
//  MockNetworkClient.swift
//  TestingBankTests
//
//  Created by Andersson on 4/03/26.
//

import Foundation
import XCTest
@testable import TestingBank

class MockNetworkClient: NetworkClientProtocol {
    var dataToReturn: Data = Data()
    var errorToThrow: Error?
    var performWasCalled = false
    var lastRequest: NetworkRequest?
    
    func perform(_ request: NetworkRequest) async throws -> Data {
        performWasCalled = true
        lastRequest = request
        
        if let error = errorToThrow {
            throw error
        }
        
        return dataToReturn
    }
}
