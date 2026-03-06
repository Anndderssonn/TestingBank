//
//  SessionValidatorTests.swift
//  TestingBankTests
//
//  Created by Andersson on 4/03/26.
//

import XCTest
@testable import TestingBank

@MainActor
final class SessionValidatorTests: XCTestCase {
    var mockRepository: MockSessionRepository!
    var sut: SessionValidator!
    
    
    override func setUp() {
        super.setUp()
        mockRepository = MockSessionRepository()
        sut = SessionValidator(repository: mockRepository)
    }
    
    override func tearDown() {
        mockRepository = nil
        sut = nil
        super.tearDown()
    }
    
    func test_whenSessionIsActive_returnsPassed() async {
        mockRepository.stateToReturn = .active
        let result = await sut.validate()
        XCTAssertEqual(result, .passed)
    }
    
    func test_whenSessionIsExpired_returnsReadyForGuest() async {
        mockRepository.stateToReturn = .expired
        let result = await sut.validate()
        XCTAssertEqual(result, .failed(.readyForGuest))
    }
    
    func test_whenSessionNotFound_returnsReadyForGuest() async {
        mockRepository.stateToReturn = .notFound
        let result = await sut.validate()
        XCTAssertEqual(result, .failed(.readyForGuest))
    }
    
    func test_whenRepositoryThrows_returnsReadyForGuest() async {
        mockRepository.errorToThrow = SplashDomainErrorModel.networkUnavailable
        let result = await sut.validate()
        XCTAssertEqual(result, .failed(.readyForGuest))
    }
    
    func test_validateCallsRepository() async {
        mockRepository.stateToReturn = .active
        _ = await sut.validate()
        XCTAssertTrue(mockRepository.fetchSessionWasCalled)
    }
}
