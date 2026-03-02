//
//  SessionValidator.swift
//  TestingBank
//
//  Created by Andersson on 1/03/26.
//

import Foundation

struct SessionValidator: StartupValidatorProtocol {
    private let repository: SessionRepositoryProtocol
    
    init(repository: SessionRepositoryProtocol) {
        self.repository = repository
    }
    
    func validate() async -> ValidationResultModel {
        guard let state = try? await repository.fetchCurrentSession() else {
            return .failed(.requiresLogin)
        }
        
        switch state {
        case .active:
            return .passed
        case .expired:
            return .failed(.requiresLogin)
        case .notFound:
            return .failed(.requiresLogin)
        }
    }
}
