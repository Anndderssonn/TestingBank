//
//  SplashPresenter.swift
//  TestingBank
//
//  Created by Andersson on 3/03/26.
//

import Foundation

class SplashPresenter {
    weak var view: SplashViewDelegate?
    var interactor: SplashInteractorDelegate?
    var router: SplashRouterDelegate?
}

extension SplashPresenter: SplashPresenterViewDelegate {
    func viewDidAppear() {
        view?.showLoading()
        interactor?.startUp()
    }
}

extension SplashPresenter: SplashPresenterInteractorDelegate {
    func startUpCompleted(result: StartupResultModel) {
        switch result {
        case .readyForHome:
            router?.navigateToHomeLoggedIn()
        case .readyForGuest:
            router?.navigateToHomeGuest()
        case .requiresOnBoarding:
            router?.navigateToOnBoarding()
        case .blocked(let reason):
            router?.navigateToBlocked(reason: reason)
        }
    }
}
