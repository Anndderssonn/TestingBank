//
//  USSessionRepositoryImpl.swift
//  TestingBank
//
//  Created by Andersson on 2/03/26.
//

import Foundation

struct USSessionRepositoryImpl: SessionRepositoryProtocol {
    private let keychainDataSource: KeychainDataSourceProtocol
    
    init(keychainDataSource: KeychainDataSourceProtocol) {
        self.keychainDataSource = keychainDataSource
    }
    
    func fetchCurrentSession() async throws -> SessionState {
        guard let token = keychainDataSource.loadToken() else {
            return .notFound
        }
        //TODO: Validate expiration data
        return token.isEmpty ? .notFound : .active
    }
}
