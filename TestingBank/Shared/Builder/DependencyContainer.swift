//
//  DependencyContainer.swift
//  TestingBank
//
//  Created by Andersson on 3/03/26.
//

import Foundation

final class DependencyContainer {
    static let shared = DependencyContainer()
    var activeCountry: CountryCode = .US
    private lazy var networkClient: NetworkClientProtocol = {
        URLSessionNetworkClient()
    }()
    
    private init() {}
    
    func makeSplashFactory() -> SplashRepositoryFactoryProtocol {
        switch activeCountry {
        case .US:
            return USSplashRepositoryFactoryImpl(networkClient: networkClient)
        case .CA:
            return CASplashRepositoryFactoryImpl(networkClient: networkClient)
        }
    }
}
