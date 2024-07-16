//
//  TestTransaction.swift
//  AccountsFeatureTests
//
//  Created by TM.Dev on 06/06/2021.
//

import AccountsFeature
import CoreStarlingEngineSharedModels
import Foundation

struct TestTransaction: Codable {
    let feedItemUid: String
    let categoryUid: String
    let amount: TestAmount
    let sourceAmount: TestSourceAmount
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
    let spendingCategory: String
    let hasAttachment: Bool
    let hasReceipt: Bool
}

struct TestAmount: Codable, Equatable, Amountable {
    public let currency: String
    public let minorUnits: Int
}

struct TestSourceAmount: Codable, Equatable, Amountable {
    public let currency: String
    public let minorUnits: Int
}

extension TestTransaction {
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
            spendingCategory: .bike,
            hasAttachment: hasAttachment,
            hasReceipt: hasReceipt
        )
    }
}

extension Array where Element == TestTransaction {
    func toModels() -> [Transaction] {
        self.compactMap {
            $0.toModel()
        }
    }
}
