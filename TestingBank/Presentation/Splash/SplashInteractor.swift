//
//  SplashInteractor.swift
//  TestingBank
//
//  Created by Andersson on 3/03/26.
//

import Foundation

class SplashInteractor {
    weak var presenter: SplashPresenterInteractorDelegate?
    private let facade: AppStartupFacade
    
    init(facade: AppStartupFacade) {
        self.facade = facade
    }
}

extension SplashInteractor: SplashInteractorDelegate {
    func startUp() {
        Task {
            let result = await facade.startUp()
            await MainActor.run {
                presenter?.startUpCompleted(result: result)
            }
        }
    }
}
