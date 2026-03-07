//
//  LoginUseCase.swift
//  TestingBank
//
//  Created by Andersson on 7/03/26.
//

import Foundation

protocol LoginUseCase {
    func execute(credentials: LoginCredentialsModel) async -> LoginResultModel
}
