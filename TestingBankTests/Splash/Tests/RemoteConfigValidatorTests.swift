//
//  RemoteConfigValidatorTests.swift
//  TestingBankTests
//
//  Created by Andersson on 4/03/26.
//

import XCTest
@testable import TestingBank

@MainActor
final class RemoteConfigValidatorTests: XCTestCase {
    var mockRepository: MockRemoteConfigRepository!
    var sut: RemoteConfigValidator!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockRemoteConfigRepository()
        sut = RemoteConfigValidator(repository: mockRepository)
    }
    
    override func tearDown() {
        mockRepository = nil
        sut = nil
        super.tearDown()
    }
    
    func test_whenConfigIsValid_returnsPassed() async {
        mockRepository.configToReturn = RemoteConfigModel(
            minimumAppVersion: "1.0.0",
            isMaintenanceModeActive: false,
            currentAppVersion: "2.0.0"
        )
        let result = await sut.validate()
        XCTAssertEqual(result, .passed)
    }
    
    func test_whenMaintenanceModeActive_returnsBlocked() async {
        mockRepository.configToReturn = RemoteConfigModel(
            minimumAppVersion: "1.0.0",
            isMaintenanceModeActive: true,
            currentAppVersion: "2.0.0"
        )
        let result = await sut.validate()
        XCTAssertEqual(result, .failed(.blocked(.maintenanceMode)))
    }
    
    func test_whenAppVersionOutdated_returnsBlocked() async {
        mockRepository.configToReturn = RemoteConfigModel(
            minimumAppVersion: "3.0.0",
            isMaintenanceModeActive: false,
            currentAppVersion: "2.0.0"
        )
        let result = await sut.validate()
        XCTAssertEqual(result, .failed(.blocked(.updateRequired)))
    }
    
    func test_whenRepositoryThrows_returnsPassed() async {
        mockRepository.errorToThrow = SplashDomainErrorModel.networkUnavailable
        let result = await sut.validate()
        XCTAssertEqual(result, .passed)
    }
}
