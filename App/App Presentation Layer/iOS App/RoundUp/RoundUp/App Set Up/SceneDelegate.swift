//
//  SceneDelegate.swift
//  RoundUp
//
//  Created by TM.Dev on 11/07/2024.
//

import AccountsFeature
import CoreNetworking
import CorePresentation
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    private var accessToken = "add-your-own"
    private var refreshToken = "add-your-own"
    private var clientID = "add-your-own"
    private var clientSecret = "add-your-own"
    
    var client: HTTPClient?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession, 
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else {
            fatalError("Window failed to initialise in SceneDelegate")
        }
        setupAuthenticationStore()
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = accountsFeed()
        window?.makeKeyAndVisible()
    }

    private func accountsFeed() -> UIViewController {
        let client = URLSessionHTTPClient()
        let router = Router(navigationController: .init())
        let coordinator = AppLaunchCoordinator(
            router: router,
            client: client
        )
        coordinator.start()
        return coordinator.router.navigationController
    }
    
    private func setupAuthenticationStore() {
        let authenticationStore = UserDefaultsAuthenticationStore(accessToken: accessToken, refreshToken: refreshToken)
        let authenticationStoreManager = UserDefaultsAuthenticationStoreManager()
        authenticationStoreManager.saveStore(authenticationStorable: authenticationStore)
    }
}
