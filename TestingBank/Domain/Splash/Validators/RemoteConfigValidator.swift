//
//  RemoteConfigValidator.swift
//  TestingBank
//
//  Created by Andersson on 1/03/26.
//

import Foundation

struct RemoteConfigValidator: StartupValidatorProtocol {
    private let repository: RemoteConfigRepositoryProtocol
    
    init(repository: RemoteConfigRepositoryProtocol) {
        self.repository = repository
    }
    
    func validate() async -> ValidationResultModel {
        guard let config = try? await repository.fetchConfig() else {
            return .passed
        }
        
        if config.isMaintenanceModeActive {
            return .failed(.blocked(.maintenanceMode))
        }
        
        if config.currentAppVersion < config.minimumAppVersion {
            return .failed(.blocked(.updateRequired))
        }
        
        return .passed
    }
}
