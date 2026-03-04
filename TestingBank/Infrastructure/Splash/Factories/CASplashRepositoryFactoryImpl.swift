//
//  CASplashRepositoryFactoryImpl.swift
//  TestingBank
//
//  Created by Andersson on 3/03/26.
//

import Foundation

struct CASplashRepositoryFactoryImpl: SplashRepositoryFactoryProtocol {
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func makeRemoteConfigRepository() -> any RemoteConfigRepositoryProtocol {
        let dataSource = CARemoteConfigDataSource(client: networkClient)
        return CARemoteConfigRepositoryImpl(dataSource: dataSource)
    }
    
    func makeSessionRepository() -> any SessionRepositoryProtocol {
        let keychain = KeychainDataSource()
        return CASessionRepositoryImpl(keychainDataSource: keychain)
    }
}
