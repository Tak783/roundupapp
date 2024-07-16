//
//  RemoteAccount.swift
//  AccountsFeature
//
//  Created by TM.Dev on 06/06/2021.
//

import Foundation

struct RemoteAccount: Codable {
    let accountUid: String
    let accountType: String
    let defaultCategory: String
    let currency: String
    let createdAt: Date
    let name: String
}

// MARK: - Convert to production models
extension RemoteAccount {
    func toModel() -> Account {
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

// MARK: - Convert to production models Array
extension Array where Element == RemoteAccount {
    func toModels() -> [Account] {
        self.compactMap {
            $0.toModel()
        }
    }
}
