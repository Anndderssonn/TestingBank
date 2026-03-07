//
//  LoginInteractor.swift
//  TestingBank
//
//  Created by Andersson on 7/03/26.
//

import Foundation

class LoginInteractor {
    weak var presenter: LoginPresenterInteractorDelegate?
    private let loginUseCase: any LoginUseCase
    private let biometricLoginUseCase: any BiometricLoginUseCase
    private let keychainDataSource: KeychainDataSourceProtocol
    
    init(
        loginUseCase: any LoginUseCase,
        biometricLoginUseCase: any BiometricLoginUseCase,
        keychainDataSource: KeychainDataSourceProtocol
    ) {
        self.loginUseCase = loginUseCase
        self.biometricLoginUseCase = biometricLoginUseCase
        self.keychainDataSource = keychainDataSource
    }
    
    private func performLogin(credentials: LoginCredentialsModel) async {
        let result = await loginUseCase.execute(credentials: credentials)
        await MainActor.run {
            presenter?.loginCompleted(result: result)
        }
    }
    
    private func performBiometricLogin() async {
        let result = await biometricLoginUseCase.execute()
        await MainActor.run {
            presenter?.biometricLoginCompleted(result: result)
        }
    }
}

extension LoginInteractor: LoginInteractorDelegate {
    func login(credentials: LoginCredentialsModel) {
        Task {
            await performLogin(credentials: credentials)
        }
    }
    
    func biometricLogin() {
        Task {
            await performBiometricLogin()
        }
    }
    
    func isBiometricAvailable() -> Bool {
        biometricLoginUseCase.isBiometricAvailable()
    }
    
    func saveToken(_ token: String) {
        keychainDataSource.saveToken(token)
    }
}
