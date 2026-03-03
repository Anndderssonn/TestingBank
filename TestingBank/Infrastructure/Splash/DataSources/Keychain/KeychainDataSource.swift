//
//  KeychainDataSource.swift
//  TestingBank
//
//  Created by Andersson on 2/03/26.
//

import Foundation

struct KeychainDataSource {
    private let tokenKey = "com.testingbank.authToken"
    
    func saveToken(_ token: String) {
        guard let data = token.data(using: .utf8) else { return }
        deleteToken()
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: tokenKey,
            kSecValueData as String: data
        ]
        SecItemAdd(query as CFDictionary, nil)
    }
    
    func loadToken() -> String? {
        let query: [String: Any] = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrAccount as String : tokenKey,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        guard status == errSecSuccess,
              let data = result as? Data,
              let token = String(data: data, encoding: .utf8) else {
            return nil
        }
        return token
    }
    
    func deleteToken() {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: tokenKey
        ]
        SecItemDelete(query as CFDictionary)
    }
}
