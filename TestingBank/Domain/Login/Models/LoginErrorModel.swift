//
//  LoginErrorModel.swift
//  TestingBank
//
//  Created by Andersson on 7/03/26.
//

import Foundation

enum LoginErrorModel: Error, Equatable {
    case invalidCredentials
    case networkunavailable
    case unknown
}
