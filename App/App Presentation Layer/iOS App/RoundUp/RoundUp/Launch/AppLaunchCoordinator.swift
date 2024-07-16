//
//  AppLaunchCoordinator.swift
//  RoundUp
//
//  Created by TM.Dev on 12/07/2024.
//

import AccountsFeature
import CoreFoundational
import CoreNetworking
import CorePresentation
import UIKit

final class AppLaunchCoordinator {
    var router: Router
    var childCoordinators = [ChildCoordinatorable]()
    let client: HTTPClient
    
    init(router: Router, client: HTTPClient) {
        self.router = router
        self.client = client
    }
    
    func start() {
        navigateToAccountsFeed()
    }
    
    func didEnd(childCoordinator: CorePresentation.ChildCoordinatorable) {
        efficientPrint("Did close parent coordinator")
    }
}

// MARK: - ParentCoordinatorable
extension AppLaunchCoordinator: ParentCoordinatorable {
    func navigateToAccountsFeed() {
        let accountsCoordinator = AccountsCoordinator(
            router: router,
            client: client,
            parentCoordinator: self
        )
        addChildCoordinator(coordinator: accountsCoordinator)
        
        accountsCoordinator.start()
    }
}
