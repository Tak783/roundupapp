//
//  TransactionFeedItemViewModelTests.swift
//  AccountsFeatureTests
//
//  Created by TM.Dev on 06/06/2021.
//

import XCTest
import CoreFoundational
import CoreNetworking
import MockNetworking
import AccountsFeature

final class TransactionFeedItemViewModelTests: XCTestCase {
    func test_init_setsInitialVariablesCorrectly() {
        let data = MockData.any_data(
            for: MockData.FileName.transaction.rawValue,
            fromBundle: MockNetworkingPackageBundleAccessor.bundle
        )
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(
                .jsonDateTimeFormatter
            )
            let transaction = try decoder.decode(
                TestTransaction.self,
                from: data
            )
            let sut = make_sut(with: transaction.toModel())

            XCTAssertEqual(sut.id, transaction.feedItemUid)
            XCTAssertEqual(sut.amount, "£14.99")
            XCTAssertEqual(sut.reference, transaction.reference)
            XCTAssertEqual(sut.date, DateFormatter.shortStyleDateTimeFormatter.string(from: transaction.transactionTime))
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}

// MARK: - Make SUT
extension TransactionFeedItemViewModelTests {
    private func make_sut(with transaction: Transaction) -> TransactionFeedItemViewModel {
        let sut = TransactionFeedItemViewModel(with: transaction)
        trackForMemoryLeaks(sut)
        return sut
    }
}
