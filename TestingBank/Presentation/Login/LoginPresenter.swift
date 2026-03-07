//
//  LoginPresenter.swift
//  TestingBank
//
//  Created by Andersson on 7/03/26.
//

import Foundation

class LoginPresenter {
    weak var view: LoginViewDelegate?
    var interactor: LoginInteractorDelegate?
    var router: LoginRouterDelegate?
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: email)
    }
    
    private func errorMessage(for error: LoginErrorModel) -> String {
        switch error {
        case .invalidCredentials:
            return "Invalid email or password."
        case .networkunavailable:
            return "Network unavailable. Please try again."
        case . unknown:
            return "An unknown error occured. Please try again."
        }
    }
    
    private func handleLoginResult(_ result: LoginResultModel) {
        view?.hideLoading()
        switch result {
        case .success(let token):
            interactor?.saveToken(token)
            router?.navigateToHomeLoggedIn()
        case .failure(let error):
            view?.showError(message: errorMessage(for: error))
        }
    }
}

extension LoginPresenter: LoginPresenterDelegate {
    func viewDidLoad() {
        let biometricAvailable = interactor?.isBiometricAvailable() ?? false
        view?.setBiometricButton(visible: biometricAvailable)
    }
    
    func loginTapped(email: String, password: String) {
        guard !email.isEmpty, !password.isEmpty else {
            view?.showError(message: "Please, enter your email and password.")
            return
        }
        guard isValidEmail(email) else {
            view?.showError(message: "Please, enter a valid email.")
            return
        }
        view?.showLoading()
        let credentials = LoginCredentialsModel(email: email, password: password)
        interactor?.login(credentials: credentials)
    }
    
    func biometricLoginTapped() {
        view?.showLoading()
        interactor?.biometricLogin()
    }
}

extension LoginPresenter: LoginPresenterInteractorDelegate {
    func loginCompleted(result: LoginResultModel) {
        handleLoginResult(result)
    }
    
    func biometricLoginCompleted(result: LoginResultModel) {
        handleLoginResult(result)
    }
}
