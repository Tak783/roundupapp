//
//  TestHelpers.swift
//  RoundUpAppTests
//
//  Created by Tak M on 06/06/2021.
//

import XCTest
import CoreFoundational
import MockNetworking
import AccountsFeature

func any_account() throws -> Account {
    let data = MockData.any_data(
        for: MockData.FileName.account.rawValue,
        fromBundle: MockNetworkingPackageBundleAccessor.bundle
    )
    return try JSONDecoder(with: .jsonDateTimeFormatter).decode(TestAccount.self, from: data).toModel()
}

func any_transaction() throws -> Transaction {
    let data = MockData.any_data(
        for: MockData.FileName.transaction.rawValue,
        fromBundle: MockNetworkingPackageBundleAccessor.bundle
    )
    return try JSONDecoder(with: .jsonDateTimeFormatter).decode(TestTransaction.self, from: data).toModel()
}

func any_transactions() throws -> [Transaction] {
    let data = MockData.any_data(
        for: MockData.FileName.transactions.rawValue,
        fromBundle: MockNetworkingPackageBundleAccessor.bundle
    )
    let expectedFeed = try! JSONDecoder(with: .jsonDateTimeFormatter).decode(TestTransactionFeed.self, from: data)
    return expectedFeed.feedItems.toModels()
}
