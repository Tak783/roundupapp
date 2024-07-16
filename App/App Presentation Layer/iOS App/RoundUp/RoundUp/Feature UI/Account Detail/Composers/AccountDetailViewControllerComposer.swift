//
//  AccountDetailComposer.swift
//  
//
//  Created by TM.Dev on 18/04/2021.
//

import AccountsFeature
import CoreFoundational
import CorePresentation
import CoreStarlingEngineSharedModels
import CoreUIKit
import SavingsGoalsFeature
import UIKit

final class AccountDetailViewControllerComposer {
    static func compose(
        with transactionsFeedService: TransactionsFeedServiceable,
        addMoneyToSavingsGoalsServicable: AddMoneyToSavingsGoalsServicable,
        account: Account,
        title: String,
        coordinator: AccountDetailCoordinating
    ) -> AccountDetailViewController {
        let weekRoundUpTotal = Amount(
            currency: account.currency,
            minorUnits: .zero
        )
        let accountDetailHeaderViewModel = makeAccountDetailHeaderViewModel(
            with: account,
            minTransactionDate: .init(),
            weekRoundUpTotal: weekRoundUpTotal
        )
        let addMoneyToSavingsGoalViewModel = AddMoneyToSavingsGoalViewModel(
            service: addMoneyToSavingsGoalsServicable
        )
        let feedViewModel = TransactionsFeedViewModel(
            with: account,
            service: transactionsFeedService, 
            coordinator: coordinator,
            title: title
        )
        let accountsFeedViewController = make(
            with: feedViewModel,
            headerViewModel: accountDetailHeaderViewModel,
            addMoneyToSavingsGoalViewModel: addMoneyToSavingsGoalViewModel
        )
        return accountsFeedViewController
    }
}

// MARK: - Create AccountsFeedViewController
extension AccountDetailViewControllerComposer {
    private static func make(
        with viewModel: TransactionsFeedViewModellable,
        headerViewModel: AccountDetailHeaderViewModellable,
        addMoneyToSavingsGoalViewModel: AddMoneyToSavingsGoalViewModellable
    ) -> AccountDetailViewController {
        let accountsFeedViewController = AccountDetailViewController.instantiate()
        accountsFeedViewController.feedViewModel = viewModel
        accountsFeedViewController.headerViewModel = headerViewModel
        accountsFeedViewController.addMoneyToSavingsGoalViewModel = addMoneyToSavingsGoalViewModel
        return accountsFeedViewController
    }
}

// MARK: - Factory Methods
extension AccountDetailViewControllerComposer {
    public static func makeAccountDetailHeaderViewModel(
        with account: Account,
        minTransactionDate: Date,
        weekRoundUpTotal: Amountable
    ) -> AccountDetailHeaderViewModel {
        AccountDetailHeaderViewModel(
            with: account,
            minimumTransactionDate: minTransactionDate,
            weeksRoundUpTotal: weekRoundUpTotal
        )
    }
}
