//
//  AccountDetailHeaderViewModelTests.swift
//  AccountsFeatureTests
//
//  Created by TM.Dev on 06/06/2021.
//

import XCTest
import CoreFoundational
import CoreNetworking
import MockNetworking
import AccountsFeature

final class AccountDetailHeaderViewModelTests: XCTestCase {
    func test_initWithAccount_setsViewModelVariablesFromAccount() throws {
        
        let account = try any_account()
        let minTransactionDate = Date()
        let weekRoundUpTotal = Amount(currency: "GBP", minorUnits: 5000)
        let expectedDateAdded = DateFormatter.shortStyleDateTimeFormatter.string(
            from: account.createdAt
        )
        
        var dateComponents = DateComponents()
        dateComponents.day = 7
        let expectedMaxTransactionDate = Calendar.current.date(
            byAdding: dateComponents,
            to: minTransactionDate
        )!
        
        let sut = make_sut(
            withAccount: account,
            minDate: minTransactionDate,
            weekRoundUpTotal: weekRoundUpTotal
        )
        XCTAssertEqual(sut.id, account.accountUid)
        XCTAssertEqual(sut.name, account.name)
        XCTAssertEqual(sut.weekRoundUpTotal, "£50.00")
        XCTAssertEqual(sut.createdAt, expectedDateAdded)
    }
}

extension AccountDetailHeaderViewModelTests {
    private func make_sut(
        withAccount account: Account,
        minDate: Date,
        weekRoundUpTotal: Amount
    ) -> AccountDetailHeaderViewModel {
        let sut = AccountDetailHeaderViewModel(
            with: account,
            minimumTransactionDate: minDate,
            weeksRoundUpTotal: weekRoundUpTotal
        )
        trackForMemoryLeaks(sut)
        return sut
    }
    
    private func any_account() throws -> Account {
        let data = MockData.any_data(
            for: MockData.FileName.account.rawValue,
            fromBundle: MockNetworkingPackageBundleAccessor.bundle
        )
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(
            .jsonDateTimeFormatter
        )
        
        return try decoder.decode(TestAccount.self, from: data).toModel()
    }
}
