//
//  AccountsAPIURLPoolTests.swift
//  AccountsFeatureTests
//
//  Created by TM.Dev on 06/06/2021.
//

import XCTest
import CoreFoundational
import CoreNetworking
import CoreTesting
@testable import AccountsFeature

final class URLPoolTests: AccountsAPIURLPoolTests {
    let expectedScheme = "https"
    let expectedHost = "api-sandbox.starlingbank.com"
    let defaultPath = "/api/v2/"
    let accessToken = "a1b23cd4e5"

    override func setUp() {
        super.setUp()
        Self.resetUserDefaults()
        setupAuthentication()
    }
}
 
// MARK: - Test Accounts
extension URLPoolTests {
    func test_accountsRequest_configuresAccountsRequestCorrectly() {
        let expectedUrlAbsoluteString = fullURL(withPathSuffix: "accounts")
        let request = URLPool.accountsRequest()
        
        assert(request: request, urlAbsoluteString: expectedUrlAbsoluteString, httpMethod: .get)
        assert(request: request, hasExpectedBearerToken: accessToken)
    }
}

// MARK: - Test Transactions Feed
extension URLPoolTests {
    func test_transactionsRequestBetween_configuresTransactionsRequestBetweenRequestCorrectly() {
        let accountUID = "fb208978-a9c9-43b7-b02a-04131951aa01"
        let categoryUID = "fb208978-a9c9-43b7-b02a-04131951aa01"
        let minTransactionTimestamp = "2024-06-01T12:34:56.000Z"
        let maxTransactionTimestamp = "2024-07-01T12:34:56.000Z"
        
        let suffix = "\(accountUID)/category/\(categoryUID)/transactions-between?minTransactionTimestamp=\(minTransactionTimestamp)&maxTransactionTimestamp=\(maxTransactionTimestamp)"
        let expectedUrlAbsoluteString = fullURL(withPathSuffix: "feed/account/" + suffix)
        
        let request = URLPool.transactionsRequestBetween(
            minTransactionTimestamp: DateFormatter.jsonDateTimeFormatter.date(from: minTransactionTimestamp)!,
            maxTransactionTimestamp: DateFormatter.jsonDateTimeFormatter.date(from: maxTransactionTimestamp)!,
            forAccountUID: accountUID,
            categoryUID: categoryUID
        )
        assert(request: request, urlAbsoluteString: expectedUrlAbsoluteString, httpMethod: .get)
        assert(request: request, hasExpectedBearerToken: accessToken)
    }
}

// MARK: - Helpers
extension URLPoolTests {
    private func setupAuthentication() {
        let mockAuthenticationStore = UserDefaultsAuthenticationStore(accessToken: accessToken, refreshToken: "f1g23hi4ej")
        let userDefaultsAuthenticationStoreManager = UserDefaultsAuthenticationStoreManager()
        userDefaultsAuthenticationStoreManager.saveStore(authenticationStorable: mockAuthenticationStore)
    }
    
    private func fullURL(withPathSuffix pathSuffix: String) -> String {
        return expectedScheme + "://" + expectedHost + defaultPath + pathSuffix
    }
}
