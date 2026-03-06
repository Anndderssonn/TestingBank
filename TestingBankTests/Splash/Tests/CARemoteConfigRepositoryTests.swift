//
//  CARemoteConfigRepositoryTests.swift
//  TestingBankTests
//
//  Created by Andersson on 4/03/26.
//

import XCTest
@testable import TestingBank

@MainActor
final class CARemoteConfigRepositoryTests: XCTestCase {
    var mockDataSource: MockRemoteConfigDataSource!
    var sut: CARemoteConfigRepositoryImpl!
    
    override func setUp() {
        super.setUp()
        mockDataSource = MockRemoteConfigDataSource()
        sut = CARemoteConfigRepositoryImpl(dataSource: mockDataSource)
    }
    
    override func tearDown() {
        mockDataSource = nil
        sut = nil
        super.tearDown()
    }
    
    func test_whenDataSourceSucceeds_returnsMappedEntity() async throws {
        mockDataSource.dtoToReturn = RemoteConfigDTO(
            minimumVersion: "2.0.0",
            maintenanceMode: false,
            currentVersion: "3.0.0"
        )
        let result = try await sut.fetchConfig()
        XCTAssertEqual(result.minimumAppVersion, "2.0.0")
        XCTAssertEqual(result.isMaintenanceModeActive, false)
        XCTAssertEqual(result.currentAppVersion, "3.0.0")
    }
    
    func test_whenDataSourceThrows_throwsDomainError() async {
        mockDataSource.errorToThrow = URLError(.notConnectedToInternet)
        do {
            _ = try await sut.fetchConfig()
            XCTFail("An error was expected, but none was thrown")
        } catch let error as SplashDomainErrorModel {
            XCTAssertEqual(error, .networkUnavailable)
        } catch {
            XCTFail("SplashDomainError was expected, but was obtained: \(error)")
        }
    }
    
    func test_fetchConfig_callsDataSource() async throws {
        _ = try await sut.fetchConfig()
        XCTAssertTrue(mockDataSource.fetchConfigWasCalled)
    }
}
