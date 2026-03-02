//
//  RemoteConfigRepository.swift
//  TestingBank
//
//  Created by Andersson on 1/03/26.
//

import Foundation

protocol RemoteConfigRepositoryProtocol {
    func fetchConfig() async throws -> RemoteConfigModel
}
