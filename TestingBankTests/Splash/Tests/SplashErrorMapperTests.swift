//
//  SplashErrorMapperTests.swift
//  TestingBankTests
//
//  Created by Andersson on 4/03/26.
//

import XCTest
@testable import TestingBank

@MainActor
final class SplashErrorMapperTests: XCTestCase {
    func test_whenNotConnectedToInternet_returnsNetworkUnavailable() {
        let error = URLError(.notConnectedToInternet)
        let result = SplashErrorMapper.toDomain(error)
        XCTAssertEqual(result, .networkUnavailable)
    }
    
    func test_whenNetworkConnectionLost_returnsNetworkUnavailable() {
        let error = URLError(.networkConnectionLost)
        let result = SplashErrorMapper.toDomain(error)
        XCTAssertEqual(result, .networkUnavailable)
    }
    
    func test_whenUnknownURLError_returnsUnknown() {
        let error = URLError(.badServerResponse)
        let result = SplashErrorMapper.toDomain(error)
        XCTAssertEqual(result, .unknown)
    }
    
    func test_whenAlreadyDomainError_returnsItDirectly() {
        let error = SplashDomainErrorModel.networkUnavailable
        let result = SplashErrorMapper.toDomain(error)
        XCTAssertEqual(result, .networkUnavailable)
    }
    
    func test_whenUnrecognizedError_returnsUnknown() {
        let error = NSError(domain: "test", code: -1)
        let result = SplashErrorMapper.toDomain(error)
        XCTAssertEqual(result, .unknown)
    }
}
