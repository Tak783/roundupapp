//
//  RoundupCalculatorTests.swift
//  AccountsFeatureTests
//
//  Created by TM.Dev on 10/06/2021.
//

import XCTest
import MockNetworking
import AccountsFeature

final class RoundupCalculatorTests: XCTestCase {
    func test_calculateRoundUp_returnsCorrectRoundoupAmountable() throws {
        let transactions = try any_transactions()
        let currency = "GBP"
        
        let expectedAmount = Amount(
            currency: currency,
            minorUnits: 4
        )
        let amount1 = RoundupCalculator.calculateRoundUp(
            forTransactions: transactions, 
            currency: currency
        ) as? Amount
        XCTAssertEqual(amount1, expectedAmount)
    }
    
    private func any_transactions() throws -> [Transaction] {
        let transaction = try any_transaction()
        return [transaction, transaction, transaction, transaction]
    }
    
    private func any_transaction() throws -> Transaction {
        let data = MockData.any_data(
            for: MockData.FileName.transaction.rawValue,
            fromBundle: MockNetworkingPackageBundleAccessor.bundle
        )
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(
            .jsonDateTimeFormatter
        )
        
        return try decoder.decode(
            TestTransaction.self,
            from: data
        ).toModel()
    }
}
