//
//  USSplashRepositoryFactoryTests.swift
//  TestingBankTests
//
//  Created by Andersson on 4/03/26.
//

import XCTest
@testable import TestingBank

@MainActor
final class USSplashRepositoryFactoryTests: XCTestCase {
    var mockNetworkClient: MockNetworkClient!
    var sut: USSplashRepositoryFactoryImpl!
    
    override func setUp() {
        super.setUp()
        mockNetworkClient = MockNetworkClient()
        sut = USSplashRepositoryFactoryImpl(networkClient: mockNetworkClient)
    }
    
    override func tearDown() {
        mockNetworkClient = nil
        sut = nil
        super.tearDown()
    }
    
    func test_makeRemoteConfigRepository_returnsCorrectType() {
        let repository = sut.makeRemoteConfigRepository()
        XCTAssertTrue(repository is USRemoteConfigRepositoryImpl)
    }
    
    func test_makeSessionRepository_returnsCorrectType() {
        let repository = sut.makeSessionRepository()
        XCTAssertTrue(repository is USSessionRepositoryImpl)
    }
}
