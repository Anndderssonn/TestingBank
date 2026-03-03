//
//  RemoteConfigDTO.swift
//  TestingBank
//
//  Created by Andersson on 2/03/26.
//

import Foundation

struct RemoteConfigDTO: Decodable {
    let minimumVersion: String
    let maintenanceMode: Bool
    let currentVersion: String
    
    enum CodingKeys: String, CodingKey {
        case minimumVersion = "minimum_version"
        case maintenanceMode = "maintenance_mode"
        case currentVersion = "current_version"
    }
}
