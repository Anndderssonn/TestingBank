//
//  CASessionRepositoryTests.swift
//  TestingBankTests
//
//  Created by Andersson on 4/03/26.
//

import XCTest
@testable import TestingBank

@MainActor
final class CASessionRepositoryTests: XCTestCase {
    var mockKeychain: MockKeychainDataSource!
    var sut: CASessionRepositoryImpl!
    
    override func setUp() {
        super.setUp()
        mockKeychain = MockKeychainDataSource()
        sut = CASessionRepositoryImpl(keychainDataSource: mockKeychain)
    }
    
    override func tearDown() {
        mockKeychain = nil
        sut = nil
        super.tearDown()
    }
    
    func test_whenNoToken_returnsNotFound() async throws {
        mockKeychain.tokenToReturn = nil
        let result = try await sut.fetchCurrentSession()
        XCTAssertEqual(result, .notFound)
    }
    
    func test_whenEmptyToken_returnsNotFound() async throws {
        mockKeychain.tokenToReturn = ""
        let result = try await sut.fetchCurrentSession()
        XCTAssertEqual(result, .notFound)
    }
    
    func test_whenValidToken_returnsActive() async throws {
        mockKeychain.tokenToReturn = "valid_token_123"
        let result = try await sut.fetchCurrentSession()
        XCTAssertEqual(result, .active)
    }
    
    func test_fetchCurrentSession_callsKeychainOnce() async throws {
        mockKeychain.tokenToReturn = "valid_token_123"
        _ = try await sut.fetchCurrentSession()
        XCTAssertTrue(mockKeychain.loadTokenWasCalled)
    }
}
