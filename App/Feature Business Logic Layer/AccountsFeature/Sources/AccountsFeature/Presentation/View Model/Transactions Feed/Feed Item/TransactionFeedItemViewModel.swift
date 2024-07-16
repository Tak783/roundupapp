//
//  TransactionFeedItemViewModel.swift
//  AccountsFeature
//
//  Created by TM.Dev on 06/06/2021.
//

import CoreFoundational
import Foundation

public final class TransactionFeedItemViewModel {
    public private(set) var transaction: Transaction
    public private(set) var id: String
    public private(set) var reference: String
    public private(set) var date: String
    public private(set) var amount: String

    public init(with transaction: Transaction) {
        self.transaction = transaction
        
        id = transaction.feedItemUid
        reference = Self.referenceTitle(
            forTransaction: transaction
        )
        amount = transaction.amount.toMajorUnits().toCurrency(
            withCode: transaction.amount.currency
        )
        date = DateFormatter.shortStyleDateTimeFormatter.string(
            from: transaction.transactionTime
        )
    }
}

// MARK: - TransactionFeedItemViewModellable
extension TransactionFeedItemViewModel: TransactionFeedItemViewModellable {
    // TODO: Handle Spending Categories: - Issue found during p1-00005-round-up
    private static func referenceTitle(
        forTransaction transaction: Transaction
    ) -> String {
        if transaction.spendingCategory == .saving {
            return "Savings Goal: \(transaction.counterPartyName)"
        } else {
            return transaction.reference ?? ""
        }
    }
}
