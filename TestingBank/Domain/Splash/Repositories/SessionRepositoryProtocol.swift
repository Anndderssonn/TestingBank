//
//  SessionRepository.swift
//  TestingBank
//
//  Created by Andersson on 1/03/26.
//

import Foundation

enum SessionState {
    case active
    case expired
    case notFound
}

protocol SessionRepositoryProtocol {
    func fetchCurrentSession() async throws -> SessionState
}
