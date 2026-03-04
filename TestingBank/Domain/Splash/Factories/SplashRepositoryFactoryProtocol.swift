//
//  SplashRepositoryFactoryProtocol.swift
//  TestingBank
//
//  Created by Andersson on 3/03/26.
//

import Foundation

protocol SplashRepositoryFactoryProtocol {
    func makeRemoteConfigRepository() -> RemoteConfigRepositoryProtocol
    func makeSessionRepository() -> SessionRepositoryProtocol
}
