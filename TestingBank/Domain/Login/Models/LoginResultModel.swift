//
//  LoginResultModel.swift
//  TestingBank
//
//  Created by Andersson on 7/03/26.
//

import Foundation

enum LoginResultModel: Equatable {
    case success(token: String)
    case failure(LoginErrorModel)
}
