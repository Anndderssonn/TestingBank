//
//  RemoteConfigMapperTests.swift
//  TestingBankTests
//
//  Created by Andersson on 4/03/26.
//

import XCTest
@testable import TestingBank

@MainActor
final class RemoteConfigMapperTests: XCTestCase {
    func test_toDomain_mapsAllFieldsCorrectly() {
        let dto = RemoteConfigDTO(
            minimumVersion: "2.0.0",
            maintenanceMode: false,
            currentVersion: "3.0.0"
        )
        let result = RemoteConfigMapper.toDomain(dto)
        XCTAssertEqual(result.minimumAppVersion, "2.0.0")
        XCTAssertEqual(result.isMaintenanceModeActive, false)
        XCTAssertEqual(result.currentAppVersion, "3.0.0")
    }
    
    func test_toDomain_whenMaintenanceModeTrue_mapsCorrectly() {
        let dto = RemoteConfigDTO(
            minimumVersion: "1.0.0",
            maintenanceMode: true,
            currentVersion: "1.0.0"
        )
        let result = RemoteConfigMapper.toDomain(dto)
        XCTAssertTrue(result.isMaintenanceModeActive)
    }
    
    func test_toDomain_preservesVersionStrings() {
        let dto = RemoteConfigDTO(
            minimumVersion: "10.5.3",
            maintenanceMode: false,
            currentVersion: "10.5.3"
        )
        let result = RemoteConfigMapper.toDomain(dto)
        XCTAssertEqual(result.minimumAppVersion, "10.5.3")
        XCTAssertEqual(result.currentAppVersion, "10.5.3")
    }
}
