//
//  TransactionsFeedServiceTestsSpec.swift
//  AccountsFeatureTests
//
//  Created by TM.Dev on 06/06/2021.
//

import XCTest

protocol TransactionsFeedServiceTestsSpec {
    func test_loadTransactions_onSuccessWithNon200Code_returnsError()
    func test_loadTransactions_onSuccessWithNonInvalidData_returnsError()
    func test_loadTransactions_onFailure_returnsError()
}

typealias TransactionsFeedServiceTest = XCTestCase & TransactionsFeedServiceTestsSpec
