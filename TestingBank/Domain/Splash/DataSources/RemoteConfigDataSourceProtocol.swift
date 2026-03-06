//
//  RemoteConfigDataSourceProtocol.swift
//  TestingBank
//
//  Created by Andersson on 5/03/26.
//

import Foundation

protocol RemoteConfigDataSourceProtocol {
    func fetchConfig() async throws -> RemoteConfigDTO
}
