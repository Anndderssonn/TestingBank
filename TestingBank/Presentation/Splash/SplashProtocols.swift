//
//  SplashProtocols.swift
//  TestingBank
//
//  Created by Andersson on 3/03/26.
//

import Foundation

protocol SplashViewDelegate: AnyObject {
    func showLoading()
    func showBlokedScreen(reason: BlockReasonModel)
}

protocol SplashPresenterViewDelegate {
    func viewDidAppear()
}

protocol SplashInteractorDelegate {
    func startUp()
}

protocol SplashPresenterInteractorDelegate: AnyObject {
    func startUpCompleted(result: StartupResultModel)
}

protocol SplashRouterDelegate {
    func navigateToHomeLoggedIn()
    func navigateToHomeGuest()
    func navigateToOnBoarding()
    func navigateToBlocked(reason: BlockReasonModel)
}
