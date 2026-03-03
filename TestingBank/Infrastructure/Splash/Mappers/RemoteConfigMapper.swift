//
//  RemoteConfigMapper.swift
//  TestingBank
//
//  Created by Andersson on 2/03/26.
//

import Foundation

struct RemoteConfigMapper {
    static func toDomain(_ dto: RemoteConfigDTO) -> RemoteConfigModel {
        RemoteConfigModel(
            minimumAppVersion: dto.minimumVersion,
            isMaintenanceModeActive: dto.maintenanceMode,
            currentAppVersion: dto.currentVersion
        )
    }
}
