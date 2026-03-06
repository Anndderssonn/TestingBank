//
//  USSplashRepositoryFactoryImpl.swift
//  TestingBank
//
//  Created by Andersson on 3/03/26.
//

import Foundation

struct USSplashRepositoryFactoryImpl: SplashRepositoryFactoryProtocol {
    private let networkClient: NetworkClientProtocol
    
    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }
    
    func makeRemoteConfigRepository() -> any RemoteConfigRepositoryProtocol {
        let dataSource = USRemoteConfigDataSource(client: networkClient)
        return USRemoteConfigRepositoryImpl(dataSource: dataSource)
    }
    
    func makeSessionRepository() -> any SessionRepositoryProtocol {
        let keychain = KeychainDataSource()
        return USSessionRepositoryImpl(keychainDataSource: keychain)
    }
}
