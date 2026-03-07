//
//  BiometricLoginUseCase.swift
//  TestingBank
//
//  Created by Andersson on 7/03/26.
//

import Foundation

protocol BiometricLoginUseCase {
    func isBiometricAvailable() -> Bool
    func execute() async -> LoginResultModel
}
