//
//  AccountsCoordinatorSpy.swift
//  RoundUpTests
//
//  Created by TM.Dev on 15/07/2024.
//

import AccountsFeature
import SavingsGoalsFeature
import CorePresentation
@testable import RoundUp
import UIKit

final class SpyAccountsCoordinator: AccountsCoordinatorable, ParentCoordinatorable {
    var router: Router
    var childCoordinators = [ChildCoordinatorable]()

    var didStart = false
    var didNavigateToAccountsFeed = false
    var didNavigateToAccountDetail = false
    var didNavigateToSavingsGoals = false

    var passedInAccount: Account?
    
    init(router: Router) {
        self.router = router
    }

    func start() {
        didStart = true
    }
    
    func navigateToAccountsFeed() {
        didNavigateToAccountsFeed = true
    }
    
    func navigateToAccountDetail(withAccount account: Account) {
        passedInAccount = account
        didNavigateToAccountDetail = true
    }
    
    func navigateToSavingsGoalFeed(withAccount account: Account) {
        passedInAccount = account
        didNavigateToSavingsGoals = true
    }
    
    func didEnd(
        childCoordinator: CorePresentation.ChildCoordinatorable
    ) {
        
    }
}
