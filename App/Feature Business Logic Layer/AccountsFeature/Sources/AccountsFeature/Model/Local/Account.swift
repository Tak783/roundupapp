//
//  Account.swift
//  AccountsFeature
//
//  Created by TM.Dev on 06/06/2021.
//

import CoreStarlingEngineSharedModels
import Foundation

public struct Account: Equatable {
    public let accountUid: String
    public let accountType: String
    public let defaultCategory: String
    public let currency: String
    public let createdAt: Date
    public let name: String
    
    public init(
        accountUid: String,
        accountType: String,
        defaultCategory: String,
        currency: String,
        createdAt: Date,
        name: String
    ) {
        self.accountUid = accountUid
        self.accountType = accountType
        self.defaultCategory = defaultCategory
        self.currency = currency
        self.createdAt = createdAt
        self.name = name
    }
}
