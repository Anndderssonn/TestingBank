//
//  LoginProtocols.swift
//  TestingBank
//
//  Created by Andersson on 7/03/26.
//

import Foundation

protocol LoginViewDelegate: AnyObject {
    func showLoading()
    func hideLoading()
    func showError(message: String)
    func setBiometricButton(visible: Bool)
}

protocol LoginPresenterDelegate: AnyObject {
    func viewDidLoad()
    func loginTapped(email: String, password: String)
    func biometricLoginTapped()
}

protocol LoginInteractorDelegate: AnyObject {
    func login(credentials: LoginCredentialsModel)
    func biometricLogin()
    func isBiometricAvailable() -> Bool
    func saveToken(_ token: String)
}

protocol LoginPresenterInteractorDelegate: AnyObject {
    func loginCompleted(result: LoginResultModel)
    func biometricLoginCompleted(result: LoginResultModel)
}

protocol LoginRouterDelegate: AnyObject {
    func navigateToHomeLoggedIn()
}
