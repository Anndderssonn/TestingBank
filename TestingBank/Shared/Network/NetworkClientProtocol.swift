//
//  NetworkClientProtocol.swift
//  TestingBank
//
//  Created by Andersson on 2/03/26.
//

import Foundation

protocol NetworkClientProtocol {
    func perform(_ request: NetworkRequest) async throws -> Data
}
