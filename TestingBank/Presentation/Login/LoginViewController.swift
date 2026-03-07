//
//  LoginViewController.swift
//  TestingBank
//
//  Created by Andersson on 7/03/26.
//

import UIKit

class LoginViewController: UIViewController {
    var presenter: LoginPresenterDelegate?
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var biometricButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login with Face ID", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(biometricLoginTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Login"
        
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(biometricButton)
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            emailTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            emailTextField.heightAnchor.constraint(equalToConstant: 44),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalTo: emailTextField.widthAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 44),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 24),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalTo: emailTextField.widthAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 44),
            
            biometricButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16),
            biometricButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.topAnchor.constraint(equalTo: biometricButton.bottomAnchor, constant: 16)
        ])
    }
    
    @objc private func loginTapped() {
        presenter?.loginTapped(
            email: emailTextField.text ?? "",
            password: passwordTextField.text ?? ""
        )
    }
    
    @objc private func biometricLoginTapped() {
        presenter?.biometricLoginTapped()
    }
}

extension LoginViewController: LoginViewDelegate {
    func showLoading() {
        activityIndicator.startAnimating()
        loginButton.isEnabled = false
        biometricButton.isEnabled = false
    }
    
    func hideLoading() {
        activityIndicator.stopAnimating()
        loginButton.isEnabled = true
        biometricButton.isEnabled = true
    }
    
    func showError(message: String) {
        let alert = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func setBiometricButton(visible: Bool) {
        biometricButton.isHidden = !visible
    }
}
