//
//  MockKeychainDataSource.swift
//  TestingBankTests
//
//  Created by Andersson on 4/03/26.
//

@testable import TestingBank

class MockKeychainDataSource: KeychainDataSourceProtocol {
    var tokenToReturn: String? = nil
    var loadTokenWasCalled = false
    var saveTokenWasCalled = false
    var deleteTokenWasCalled = false
    
    func loadToken() -> String? {
        loadTokenWasCalled = true
        return tokenToReturn
    }
    
    func saveToken(_ token: String) {
        saveTokenWasCalled = true
    }
    
    func deleteToken() {
        deleteTokenWasCalled = true
    }
}
