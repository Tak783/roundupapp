//
//  TestAccount.swift
//  AccountsFeatureTests
//
//  Created by TM.Dev on 06/06/2021.
//

import AccountsFeature
import Foundation

public struct TestAccount: Codable {
    let accountUid: String
    let accountType: String
    let defaultCategory: String
    let currency: String
    let createdAt: Date
    let name: String

    public func toModel() -> Account {
        Account(
            accountUid: accountUid,
            accountType: accountType,
            defaultCategory: defaultCategory,
            currency: currency,
            createdAt: createdAt,
            name: name
        )
    }
}

extension Array where Element == TestAccount {
    public func toModels() -> [Account] {
        self.compactMap {
            $0.toModel()
        }
    }
}
