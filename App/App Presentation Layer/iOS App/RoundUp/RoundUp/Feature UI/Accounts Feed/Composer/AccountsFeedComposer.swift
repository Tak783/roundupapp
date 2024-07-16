//
//  AccountsFeedComposer.swift
//  RoundUp
//
//  Created by TM.Dev on 12/07/2024.
//

import AccountsFeature
import CoreFoundational
import CorePresentation
import UIKit

final class AccountsFeedComposer {
    static func compose(
        with service: AccountsFeedServiceable,
        title: String,
        coordinator: AccountsCoordinatorable
    ) -> AccountsFeedViewController {
        let viewModel = AccountsFeedViewModel(
            accountsFeedService: service,
            title: title, 
            coordinator: coordinator
        )
        let accountsFeedViewController = make(
            with: viewModel
        )
        return accountsFeedViewController
    }
}

// MARK: - Create AccountsFeedViewController
extension AccountsFeedComposer {
    private static func make(
        with viewModel: AccountsFeedViewModellable
    ) -> AccountsFeedViewController {
        let accountsFeedViewController = AccountsFeedViewController.instantiate()
        accountsFeedViewController.feedViewModel = viewModel
        return accountsFeedViewController
    }
}
