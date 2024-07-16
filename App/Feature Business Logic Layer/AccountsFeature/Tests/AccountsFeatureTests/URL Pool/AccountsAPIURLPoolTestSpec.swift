//
//  AccountsAPIURLPoolTestSpec.swift
//  AccountsFeatureTests
//
//  Created by TM.Dev on 06/06/2021.
//

import XCTest

typealias AccountsAPIURLPoolTests = XCTestCase & AccountsAPIURLPoolTestSpec

protocol AccountsAPIURLPoolTestSpec {
    func test_accountsRequest_configuresAccountsRequestCorrectly()
    func test_transactionsRequestBetween_configuresTransactionsRequestBetweenRequestCorrectly()
}
