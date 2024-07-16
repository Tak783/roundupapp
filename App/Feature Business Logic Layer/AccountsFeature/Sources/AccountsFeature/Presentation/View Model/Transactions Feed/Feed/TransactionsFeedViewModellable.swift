//
//  TransactionsViewModellable.swift
//  AccountsFeature
//
//  Created by TM.Dev on 06/06/2021.
//

import CoreFoundational
import CoreStarlingEngineSharedModels
import Foundation

public protocol TransactionsFeedViewModellable: AnyObject {
    var title: String { get }

    var onLoadingStateChange: Observer<Bool>? { get set }
    var onFeedLoadError: Observer<String?>? { get set }
    var onFeedLoadSuccess: Observer<Amountable>? { get set }

    var transactionsFeedService: TransactionsFeedServiceable { get set }
    var transactionFeedItemViewModels: [TransactionFeedItemViewModel] { get }
    
    func reloadTransactions(
        minTransactionTimestamp: Date,
        maxTransactionTimestamp: Date
    )
    func didAddToSavingsGoal()
    func didRequestToSelectSavingsGoal()
    func didRequestToNavigateToSavingsGoalsFeed()
}
