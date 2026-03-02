//
//  StartupResult.swift
//  TestingBank
//
//  Created by Andersson on 1/03/26.
//

import Foundation

enum StartupResultModel {
    case readyForHome
    case requiresLogin
    case requiresOnBoarding
    case blocked(BlockReasonModel)
}
