//
//  CARemoteConfigRepositoryImpl.swift
//  TestingBank
//
//  Created by Andersson on 2/03/26.
//

import Foundation

struct CARemoteConfigRepositoryImpl: RemoteConfigRepositoryProtocol {
    private let dataSource: CARemoteConfigDataSource
    
    init(dataSource: CARemoteConfigDataSource) {
        self.dataSource = dataSource
    }
    
    func fetchConfig() async throws -> RemoteConfigModel {
        do {
            let dto = try await dataSource.fetchConfig()
            return RemoteConfigMapper.toDomain(dto)
        } catch {
            throw SplashErrorMapper.toDomain(error)
        }
    }
}
