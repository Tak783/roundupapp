//
//  SpyAccountsSavingsCoordinator.swift
//
//
//  Created by TM.Dev on 15/07/2024.
//

import AccountsFeature
import Foundation

final class SpyAccountsSavingsCoordinator: AccountsSavingsCoordinatorable {
    var addedToSavingsGoal = false
    var didNavigateToSavingsGoals = false
    var didNavigateToSelectSavingsGoal = false

    func didAddToSavingsGoal() {
        addedToSavingsGoal = true
    }
    
    func navigateToSavingsGoalFeed(withAccount account: AccountsFeature.Account) {
        didNavigateToSavingsGoals = true
    }
    
    func navigateToSelectSavingsGoal(for account: AccountsFeature.Account) {
        didNavigateToSelectSavingsGoal = true
    }
}
