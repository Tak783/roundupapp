//
//  TransactionsFeedViewModel.swift
//  AccountsFeature
//
//  Created by TM.Dev on 06/06/2021.
//

import CoreFoundational
import CoreStarlingEngineSharedModels
import Foundation

public final class TransactionsFeedViewModel {
    public var title: String
    
    public var transactionsFeedService: TransactionsFeedServiceable
    public var onFeedLoadError: Observer<String?>?
    public var onLoadingStateChange: Observer<Bool>?
    public var onFeedLoadSuccess: Observer<Amountable>?
    public var onFilteredTransactionsUpdate: Observer<Void>?

    public private(set) var account: Account
    public private(set) var transactionFeedItemViewModels = [TransactionFeedItemViewModel]()
    public private(set) var allTransactionFeedItemViewModels = [TransactionFeedItemViewModel]()
    
    private weak var coordinator: AccountsSavingsCoordinatorable?
    
    public init(
        with account: Account,
        service: TransactionsFeedServiceable,
        coordinator: AccountsSavingsCoordinatorable?,
        title: String
    ) {
        self.account = account
        self.transactionsFeedService = service
        self.title = title
        self.coordinator = coordinator
    }
}

// MARK: - TransactionsFeedViewModellable
extension TransactionsFeedViewModel: TransactionsFeedViewModellable {
    public func reloadTransactions(minTransactionTimestamp: Date, maxTransactionTimestamp: Date) {
        onLoadingStateChange?(true)
        transactionsFeedService.loadTransactions(
            forAccountUID: account.accountUid,
            categoryUID: account.defaultCategory,
            minTransactionTimestamp: minTransactionTimestamp,
            maxTransactionTimestamp: maxTransactionTimestamp
        ) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let transactions):
                self.didSuccessfullyFetchTransactions(transactions)
            case .failure:
                self.onFeedLoadError?("Failed to load feed")
            }
            self.onLoadingStateChange?(false)
        }
    }
    
    public func didAddToSavingsGoal() {
        coordinator?.didAddToSavingsGoal()
    }
    
    public func didRequestToSelectSavingsGoal() {
        coordinator?.navigateToSelectSavingsGoal(
            for: account
        )
    }
    
    public func didRequestToNavigateToSavingsGoalsFeed() {
        coordinator?.navigateToSavingsGoalFeed(
            withAccount: account
        )
    }
    
    public func filterTransactions(with query: String) {
           guard !query.isEmpty else {
               transactionFeedItemViewModels = allTransactionFeedItemViewModels
               onFilteredTransactionsUpdate?(())
               return
           }

           let lowercasedQuery = query.lowercased()

           transactionFeedItemViewModels = allTransactionFeedItemViewModels.filter {
               $0.id.lowercased().contains(lowercasedQuery)
               || $0.reference.lowercased().contains(lowercasedQuery)
               || $0.amount.lowercased().contains(lowercasedQuery)
               || $0.date.lowercased().contains(lowercasedQuery)
           }

           onFilteredTransactionsUpdate?(())
       }

}

// MARK: - Factory Helper Methods
extension TransactionsFeedViewModel {
    private func didSuccessfullyFetchTransactions(_ transactions: [Transaction]) {
          let updatedRoundUpTotal = RoundupCalculator.calculateRoundUp(
              forTransactions: transactions,
              currency: account.currency
          )
          let vms = Self.adaptAccountTransactionsToCellControllers(for: transactions)
          allTransactionFeedItemViewModels = vms
          transactionFeedItemViewModels = vms
          onFeedLoadSuccess?(updatedRoundUpTotal)
      }
}

// MARK: - Factory Helper Methods
extension TransactionsFeedViewModel {
    private static func adaptAccountTransactionsToCellControllers(
        for transactions: [Transaction]
    ) -> [TransactionFeedItemViewModel] {
        return transactions.map { transaction in
            return TransactionFeedItemViewModel(with: transaction)
        }
    }
    
    private static func makeAccountDetailHeaderViewModel(
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
