//
//  SplashViewController.swift
//  TestingBank
//
//  Created by Andersson on 3/03/26.
//

import UIKit

class SplashViewController: UIViewController {
    var presenter: SplashPresenterViewDelegate?
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "building.columns.fill")
        imageView.tintColor = .white
        return imageView
    }()
    
    private let appNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Testing Bank"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .white
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.viewDidAppear()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 0.1, green: 0.2, blue: 0.5, alpha: 1.0)
        view.addSubview(logoImageView)
        view.addSubview(appNameLabel)
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60),
            logoImageView.widthAnchor.constraint(equalToConstant: 80),
            logoImageView.heightAnchor.constraint(equalToConstant: 80),
            
            appNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appNameLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 16),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.topAnchor.constraint(equalTo: appNameLabel.bottomAnchor, constant: 32)
        ])
    }
}

extension SplashViewController: SplashViewDelegate {
    func showLoading() {
        activityIndicator.startAnimating()
    }
    
    func showBlokedScreen(reason: BlockReasonModel) {
        activityIndicator.stopAnimating()
        let message: String
        switch reason {
        case .jailBreak:
            message = "This device is not compatible with TestingApp."
        case .updateRequired:
            message = "Please update app to continue."
        case .maintenanceMode:
            message = "App is under maintenance. Please try again later."
        }
        
        let alert = UIAlertController(title: "We cannot coninue", message: message, preferredStyle: .alert)
        present(alert, animated: true)
    }
}
