//
//  TransactionFeedServiceable.swift
//  AccountsFeature
//
//  Created by TM.Dev on 06/06/2021.
//

import Foundation

public protocol TransactionsFeedServiceable: AnyObject  {
    typealias TransactionsResult = Swift.Result<[Transaction], Error>
    
    func loadTransactions(
        forAccountUID accountUID: String,
        categoryUID: String,
        minTransactionTimestamp: Date,
        maxTransactionTimestamp: Date,
        completion: @escaping (TransactionsResult) -> Void
    )
}
