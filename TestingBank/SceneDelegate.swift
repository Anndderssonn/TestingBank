//
//  SceneDelegate.swift
//  TestingBank
//
//  Created by Andersson on 1/03/26.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        let factory = DependencyContainer.shared.makeSplashFactory()
        let splashViewController = SplashModuleBuilder.build(factory: factory)
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = splashViewController
        window?.makeKeyAndVisible()
    }
}

