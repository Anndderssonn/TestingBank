//
//  USRemoteConfigRepositoryImpl.swift
//  TestingBank
//
//  Created by Andersson on 2/03/26.
//

import Foundation

struct USRemoteConfigRepositoryImpl: RemoteConfigRepositoryProtocol {
    private let dataSource: RemoteConfigDataSourceProtocol
    
    init(dataSource: RemoteConfigDataSourceProtocol) {
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
