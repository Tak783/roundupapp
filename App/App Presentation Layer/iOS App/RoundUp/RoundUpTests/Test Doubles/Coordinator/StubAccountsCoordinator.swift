//
//  StubAccountsCoordinator.swift
//  RoundUpTests
//
//  Created by TM.Dev on 15/07/2024.
//

import AccountsFeature
import CorePresentation
@testable import RoundUp
import UIKit

final class SpyAccountDetailCoordinator: AccountDetailCoordinating {
    var addedToSavingsGoal = false
    var didNavigateToAccountsFeed = false
    var didNavigateToAccountsDetail = false
    var didNavigateToSavingGoalFeed = false
    var didNavigateToSelectSavingGoalFeed = false
    
    func navigateToAccountsFeed() {
        didNavigateToAccountsFeed = true
    }
    
    func navigateToAccountDetail(
        withAccount account: AccountsFeature.Account
    ) {
        didNavigateToAccountsDetail = true
    }
    
    func didAddToSavingsGoal() {
        addedToSavingsGoal = true
    }
    
    func navigateToSavingsGoalFeed(withAccount account: AccountsFeature.Account) {
        didNavigateToSelectSavingGoalFeed = true
    }
    
    func navigateToSelectSavingsGoal(for account: AccountsFeature.Account) {
        didNavigateToSelectSavingGoalFeed = true
    }
}
