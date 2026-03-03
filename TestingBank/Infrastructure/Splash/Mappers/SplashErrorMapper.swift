//
//  SplashErrorMapper.swift
//  TestingBank
//
//  Created by Andersson on 2/03/26.
//

import Foundation

struct SplashErrorMapper {
    static func toDomain(_ error: Error) -> SplashDomainError {
        if let domainError = error as? SplashDomainError {
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
