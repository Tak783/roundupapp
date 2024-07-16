//
//  SpyAccountsCoordinator.swift
//
//
//  Created by TM.Dev on 15/07/2024.
//

import AccountsFeature
import Foundation

final class SpyAccountsCoordinator: AccountsCoordinatorable {
    var didNavigateToAccountsFeed = false
    var didNavigateToAccountDetail = false
    
    func navigateToAccountsFeed() {
        didNavigateToAccountsFeed = true
    }
    
    func navigateToAccountDetail(withAccount account: Account) {
        didNavigateToAccountDetail = true
    }
}
