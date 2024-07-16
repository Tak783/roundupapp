//
//  Transaction.swift
//  AccountsFeature
//
//  Created by TM.Dev on 06/06/2021.
//

import CoreStarlingEngineSharedModels
import Foundation

public struct Transaction: Equatable {
    public let feedItemUid: String
    public let categoryUid: String
    public let amount: Amount
    public let sourceAmount: SourceAmount
    public let direction: String
    public let updatedAt: Date
    public let transactionTime: Date
    public let source: String
    public let status: String
    public let counterPartyType: String
    public let counterPartyUid: String?
    public let counterPartyName: String
    public let counterPartySubEntityUid: String?
    public let reference: String?
    public let country: String
    public let spendingCategory: SpendingCategory
    public let hasAttachment: Bool
    public let hasReceipt: Bool
    
    public init(
        feedItemUid: String,
        categoryUid: String,
        amount: Amount,
        sourceAmount: SourceAmount,
        direction: String,
        updatedAt: Date,
        transactionTime: Date,
        source: String,
        status: String,
        counterPartyType: String,
        counterPartyUid: String?,
        counterPartyName: String,
        counterPartySubEntityUid: String?,
        reference: String?,
        country: String,
        spendingCategory: SpendingCategory,
        hasAttachment: Bool,
        hasReceipt: Bool
    ) {
        self.feedItemUid = feedItemUid
        self.categoryUid = categoryUid
        self.amount = amount
        self.sourceAmount = sourceAmount
        self.direction = direction
        self.updatedAt = updatedAt
        self.transactionTime = transactionTime
        self.source = source
        self.status = status
        self.counterPartyType = counterPartyType
        self.counterPartyUid = counterPartyUid
        self.counterPartyName = counterPartyName
        self.counterPartySubEntityUid = counterPartySubEntityUid
        self.reference = reference
        self.country = country
        self.spendingCategory = spendingCategory
        self.hasAttachment = hasAttachment
        self.hasReceipt = hasReceipt
    }
}
