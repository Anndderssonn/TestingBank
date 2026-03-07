//
//  LoginRepository.swift
//  TestingBank
//
//  Created by Andersson on 7/03/26.
//

import Foundation

protocol LoginRepository {
    func login(credentials: LoginCredentialsModel) async throws -> String
}
