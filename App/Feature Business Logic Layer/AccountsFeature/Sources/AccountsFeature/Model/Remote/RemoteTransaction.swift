//
//  RemoteTransaction.swift
//  AccountsFeature
//
//  Created by TM.Dev on 06/06/2021.
//

import CoreStarlingEngineSharedModels
import Foundation

struct RemoteTransaction: Codable {
    let feedItemUid: String
    let categoryUid: String
    let amount: RemoteAmount
    let sourceAmount: RemoteSourceAmount
    let direction: String
    let updatedAt: Date
    let transactionTime: Date
    let source: String
    let status: String
    let counterPartyType: String
    let counterPartyUid: String?
    let counterPartyName: String
    let counterPartySubEntityUid: String?
    let reference: String?
    let country: String
    let spendingCategory: SpendingCategory
    let hasAttachment: Bool
    let hasReceipt: Bool
}

// MARK: - To production model
extension RemoteTransaction {
    func toModel() -> Transaction {
        Transaction(
            feedItemUid: feedItemUid,
            categoryUid: categoryUid,
            amount: Amount(currency: amount.currency, minorUnits: amount.minorUnits),
            sourceAmount: SourceAmount(currency: sourceAmount.currency, minorUnits: sourceAmount.minorUnits),
            direction: direction,
            updatedAt: updatedAt,
            transactionTime: transactionTime,
            source: source,
            status: status,
            counterPartyType: counterPartyType,
            counterPartyUid: counterPartyUid,
            counterPartyName: counterPartyName,
            counterPartySubEntityUid: counterPartySubEntityUid,
            reference: reference,
            country: country,
            spendingCategory: spendingCategory,
            hasAttachment: hasAttachment,
            hasReceipt: hasReceipt
        )
    }
}

// MARK: - To production models array
extension Array where Element == RemoteTransaction {
    func toModels() -> [Transaction] {
        self.compactMap {
            $0.toModel()
        }
    }
}
