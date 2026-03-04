//
//  SplashErrorMapper.swift
//  TestingBank
//
//  Created by Andersson on 2/03/26.
//

import Foundation

struct SplashErrorMapper {
    static func toDomain(_ error: Error) -> SplashDomainErrorModel {
        if let domainError = error as? SplashDomainErrorModel {
            return domainError
        }
        if let urlError = error as? URLError {
            switch urlError.code {
            case .notConnectedToInternet,
                    .networkConnectionLost:
                return .networkUnavailable
            default:
                return .unknown
            }
        }
        return .unknown
    }
}
