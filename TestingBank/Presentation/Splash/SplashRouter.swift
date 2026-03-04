//
//  SplashRouter.swift
//  TestingBank
//
//  Created by Andersson on 3/03/26.
//

import UIKit

class SplashRouter {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController? = nil) {
        self.viewController = viewController
    }
}

extension SplashRouter: SplashRouterDelegate {
    func navigateToHomeLoggedIn() {
        // TODO: Create HomeVC
        let homeVC = UIViewController()
        homeVC.view.backgroundColor = .systemGray
        homeVC.title = "Home LoggedIn"
        setRootViewController(homeVC)
    }
    
    func navigateToHomeGuest() {
        // TODO: Create HomeVC Guest
        let homeVc = UIViewController()
        homeVc.view.backgroundColor = .systemBlue
        homeVc.title = "Home Guest"
        setRootViewController(homeVc)
    }
    
    func navigateToOnBoarding() {
        // TODO: Crate OnBoardingVC
        let homeVc = UIViewController()
        homeVc.view.backgroundColor = .systemOrange
        homeVc.title = "OnBoarding"
        setRootViewController(homeVc)
    }
    
    func navigateToBlocked(reason: BlockReasonModel) {
        // TODO: Crate BlockScreen
        let homeVc = UIViewController()
        homeVc.view.backgroundColor = .systemRed
        homeVc.title = "Blocked: \(reason)"
        setRootViewController(homeVc)
    }
    
    private func setRootViewController(_ viewController: UIViewController) {
        guard let window = self.viewController?.view.window else { return }
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve) {
            window.rootViewController = viewController
        }
    }
}
