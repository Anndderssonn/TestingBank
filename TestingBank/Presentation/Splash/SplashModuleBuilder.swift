//
//  SplashModuleBuilder.swift
//  TestingBank
//
//  Created by Andersson on 3/03/26.
//

import UIKit

enum SplashModuleBuilder {
    static func build(factory: SplashRepositoryFactoryProtocol) -> UIViewController {
        let remoteConfigRepository = factory.makeRemoteConfigRepository()
        let sessionRepository = factory.makeSessionRepository()
        let jailBreakValidator = JailBreakValidator()
        let remoteConfigValidator = RemoteConfigValidator(repository: remoteConfigRepository)
        let sessionValidator = SessionValidator(repository: sessionRepository)
        let onBoardingValidator = OnboardingValidator(
            hasCompleteOnboarding: UserDefaults.standard.bool(forKey: "hasCompletedOnboarding")
        )
        let facade = AppStartupFacade(validators: [
            jailBreakValidator,
            remoteConfigValidator,
            sessionValidator,
            onBoardingValidator
        ])
        
        let viewController = SplashViewController()
        let presenter = SplashPresenter()
        let interactor = SplashInteractor(facade: facade)
        let router = SplashRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return viewController
    }
}
