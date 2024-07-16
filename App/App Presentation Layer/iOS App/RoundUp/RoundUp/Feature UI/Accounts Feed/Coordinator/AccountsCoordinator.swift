//
//  AccountsCoordinator.swift
//  
//
//  Created by TM.Dev on 16/04/2021.
//

import UIKit
import CoreFoundational
import CoreNetworking
import CorePresentation
import AccountsFeature
import SavingsGoalsFeature

final class AccountsCoordinator: ChildCoordinatorable, ParentCoordinatorable {
    var childCoordinators: [ChildCoordinatorable] = []
    let client: HTTPClient
    var router: Router
    var parentCoordinator: ParentCoordinatorable?
    
    init(
        router: Router,
        client: HTTPClient,
        parentCoordinator: ParentCoordinatorable?
    ) {
        self.router = router
        self.client = client
        self.parentCoordinator = parentCoordinator
    }

    func start() {
        navigateToAccountsFeed()
    }
    
    func didEnd(childCoordinator: CorePresentation.ChildCoordinatorable) {
        efficientPrint("Did close Child Coordinator")
    }
}
 
// MARK: - AccountsCoordinatorable
extension AccountsCoordinator: AccountsCoordinatorable {
    func navigateToAccountsFeed() {
        let accountsFeedService = RemoteAccountsFeedService(client: client)
        let accountsFeedViewController = AccountsFeedComposer.compose(
            with: accountsFeedService,
            title: Localized.Accounts.feed,
            coordinator: self
        )
        router.navigateToViewController(accountsFeedViewController, withMethod: .push)
    }
    
    func navigateToAccountDetail(withAccount account: Account) {
        let transactionsService = RemoteTransactionsFeedService(client: client)
        let addMoneyToSavingsGoalsService = RemoteAddMoneyToSavingsGoalsService(
            client: client,
            forAccountUID: account.accountUid,
            currency: account.currency
        )
        let accountsDetailViewController = AccountDetailViewControllerComposer.compose(
            with: transactionsService,
            addMoneyToSavingsGoalsServicable: addMoneyToSavingsGoalsService,
            account: account,
            title: Localized.Accounts.detail,
            coordinator: self
        )
        router.navigateToViewController(accountsDetailViewController, withMethod: .push)
    }
}

// MARK: - AccountsSavingsCoordinatorable
extension AccountsCoordinator: AccountsSavingsCoordinatorable {
    func navigateToSavingsGoalFeed(withAccount account: Account) {
        let router = Router(navigationController: .init())
        let savingsCoordinator = SavingsGoalsCoordinator(
            router: router,
            account: account,
            client: client,
            parentCoordinator: parentCoordinator
        )
        savingsCoordinator.start()
        openChild(savingsCoordinator)
    }
    
    func navigateToSelectSavingsGoal(for account: Account) {
        let router = Router(navigationController: .init())
        let savingsCoordinator = SavingsGoalsCoordinator(
            router: router,
            account: account,
            client: client,
            parentCoordinator: parentCoordinator
        )
        savingsCoordinator.navigateToSavingsGoalFeed(forState: .goalSelection)
        openChild(savingsCoordinator)
    }
    
    func didAddToSavingsGoal() {
        router.popViewController()
    }
}
