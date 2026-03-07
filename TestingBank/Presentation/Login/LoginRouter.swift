//
//  LoginRouter.swift
//  TestingBank
//
//  Created by Andersson on 7/03/26.
//

import UIKit

class LoginRouter {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController? = nil) {
        self.viewController = viewController
    }
    
    private func setRootViewController(_ viewController: UIViewController) {
        guard let window = self.viewController?.view.window else { return }
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve) {
            window.rootViewController = viewController
        }
    }
}

extension LoginRouter: LoginRouterDelegate {
    func navigateToHomeLoggedIn() {
        // TODO: Replace with a real homeLoggedInVC
        let homeVC = UIViewController()
        homeVC.view.backgroundColor = .systemGray
        homeVC.title = "Home LoggedIn"
        setRootViewController(homeVC)
    }
}
