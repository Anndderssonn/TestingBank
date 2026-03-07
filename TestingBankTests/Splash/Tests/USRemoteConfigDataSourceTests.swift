//
//  USRemoteConfigDataSourceTests.swift
//  TestingBankTests
//
//  Created by Andersson on 4/03/26.
//

import XCTest
@testable import TestingBank

@MainActor
final class USRemoteConfigDataSourceTests: XCTestCase {
    var mockNetworkClient: MockNetworkClient!
    var sut: USRemoteConfigDataSource!
    
    override func setUp() {
        super.setUp()
        mockNetworkClient = MockNetworkClient()
        sut = USRemoteConfigDataSource(client: mockNetworkClient)
    }
    
    override func tearDown() {
        mockNetworkClient = nil
        sut = nil
        super.tearDown()
    }
    
    func test_whenValidJSON_returnsDTO() async throws {
        let json = """
           {
               "minimum_version": "1.0.0",
               "maintenance_mode": false,
               "current_version": "2.0.0"
           }
           """.data(using: .utf8)!
        mockNetworkClient.dataToReturn = json
        let result = try await sut.fetchConfig()
        XCTAssertEqual(result.minimumVersion,  "1.0.0")
        XCTAssertEqual(result.maintenanceMode, false)
        XCTAssertEqual(result.currentVersion,  "2.0.0")
    }
    
    func test_whenClientThrows_propagatesError() async {
        mockNetworkClient.errorToThrow = URLError(.notConnectedToInternet)
        do {
            _ = try await sut.fetchConfig()
            XCTFail("Error was expected but was not thrown")
        } catch {
            XCTAssertTrue(error is URLError)
        }
    }
    
    func test_whenInvalidJSON_throwsDecodingError() async {
        mockNetworkClient.dataToReturn = "invalid json".data(using: .utf8)!
        do {
            _ = try await sut.fetchConfig()
            XCTFail("Error was expected but was not thrown")
        } catch {
            XCTAssertTrue(error is DecodingError)
        }
    }
    
    func test_fetchConfig_usesCorrectURL() async throws {
        mockNetworkClient.dataToReturn = """
           {
               "minimum_version": "1.0.0",
               "maintenance_mode": false,
               "current_version": "2.0.0"
           }
           """.data(using: .utf8)!
        _ = try await sut.fetchConfig()
        XCTAssertEqual(
            mockNetworkClient.lastRequest?.url,
            "https://api.us.testingbank.com/v1/config"
        )
    }
    
    func test_fetchConfig_usesGETMethod() async throws {
        mockNetworkClient.dataToReturn = """
           {
               "minimum_version": "1.0.0",
               "maintenance_mode": false,
               "current_version": "2.0.0"
           }
           """.data(using: .utf8)!
        _ = try await sut.fetchConfig()
        XCTAssertEqual(mockNetworkClient.lastRequest?.method, .GET)
    }
}
