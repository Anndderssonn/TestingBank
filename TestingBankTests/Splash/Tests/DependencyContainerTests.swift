//
//  DependencyContainerTests.swift
//  TestingBankTests
//
//  Created by Andersson on 4/03/26.
//

import XCTest
@testable import TestingBank

@MainActor
final class DependencyContainerTests: XCTestCase {
    override func setUp() {
        super.setUp()
        DependencyContainer.shared.activeCountry = .US
    }
    
    override func tearDown() {
        DependencyContainer.shared.activeCountry = .US
        super.tearDown()
    }
    
    func test_whenCountryIsUS_returnsUSFactory() {
        DependencyContainer.shared.activeCountry = .US
        let factory = DependencyContainer.shared.makeSplashFactory()
        XCTAssertTrue(factory is USSplashRepositoryFactoryImpl)
    }
    
    func test_whenCountryIsCA_returnsCAFactory() {
        DependencyContainer.shared.activeCountry = .CA
        let factory = DependencyContainer.shared.makeSplashFactory()
        XCTAssertTrue(factory is CASplashRepositoryFactoryImpl)
    }
    
    func test_shared_returnsSameInstance() {
        let instanceOne = DependencyContainer.shared
        let instanceTwo = DependencyContainer.shared
        XCTAssertTrue(instanceOne === instanceTwo)
    }
}
