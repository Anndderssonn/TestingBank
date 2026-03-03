//
//  NetworkClient.swift
//  TestingBank
//
//  Created by Andersson on 2/03/26.
//

import Foundation

protocol NetworkClient {
    func perform(_ request: NetworkRequest) async throws -> Data
}
