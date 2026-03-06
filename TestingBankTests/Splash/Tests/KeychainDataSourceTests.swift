//
//  KeychainDataSourceTests.swift
//  TestingBankTests
//
//  Created by Andersson on 4/03/26.
//

import XCTest
@testable import TestingBank

@MainActor
final class KeychainDataSourceTests: XCTestCase {
    var sut: KeychainDataSource!
    
    override func setUp() {
        super.setUp()
        sut = KeychainDataSource()
        sut.deleteToken()
    }
    
    override func tearDown() {
        sut.deleteToken()
        sut = nil
        super.tearDown()
    }
    
    func test_whenNoTokenSaved_returnsNil() {
        let result = sut.loadToken()
        XCTAssertNil(result)
    }
    
    func test_whenTokenSaved_returnsToken() {
        let token = "test_token_123"
        sut.saveToken(token)
        let result = sut.loadToken()
        XCTAssertEqual(result, token)
    }
    
    func test_whenTokenDeleted_returnsNil() {
        sut.saveToken("test_token_123")
        sut.deleteToken()
        let result = sut.loadToken()
        XCTAssertNil(result)
    }
    
    func test_whenTokenSavedTwice_returnsLastToken() {
        sut.saveToken("first_token")
        sut.saveToken("second_token")
        let result = sut.loadToken()
        XCTAssertEqual(result, "second_token")
    }
    
    func test_whenEmptyTokenSaved_returnsNil() {
        sut.saveToken("")
        let result = sut.loadToken()
        XCTAssertNil(result)
    }
}
