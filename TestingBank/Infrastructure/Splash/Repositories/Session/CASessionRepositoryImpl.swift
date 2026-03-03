//
//  CASessionRepositoryImpl.swift
//  TestingBank
//
//  Created by Andersson on 2/03/26.
//

import Foundation

struct CASessionRepositoryImpl: SessionRepositoryProtocol {
    private let keychainDataSource: KeychainDataSource
    
    init(keychainDataSource: KeychainDataSource) {
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
