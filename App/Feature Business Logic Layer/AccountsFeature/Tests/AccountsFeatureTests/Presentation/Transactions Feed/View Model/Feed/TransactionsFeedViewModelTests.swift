//
//  TransactionsFeedViewModelTests.swift
//  AccountsFeatureTests
//
//  Created by TM.Dev on 06/06/2021.
//

import AccountsFeature
import CoreFoundational
import CoreNetworking
import MockNetworking
import Foundation
import XCTest

final class TransactionsFeedViewModelTests: TransactionsFeedViewModelTest {
    let minTransactionTimestamp = DateFormatter.jsonDateTimeFormatter.date(from: "2024-06-30T12:34:56.000Z")!
    let maxTransactionTimestamp = DateFormatter.jsonDateTimeFormatter.date(from: "2024-07-30T12:34:56.000Z")!
    
    func test_init_setsInitialVariablesCorrectly() {
        let title = "Accounts Feed"
        let client = HTTPClientSpy()
        let remoteTransactionFeedService = RemoteTransactionsFeedService(client: client)
        let (sut, _) = make_sut(transactionFeedService: remoteTransactionFeedService, title: title)

        XCTAssertEqual(sut.title, title)
        XCTAssertNotNil(sut.transactionsFeedService as? RemoteTransactionsFeedService)
    }

    func test_loadFeed_setsLoadStateToTrue() {
        let client = HTTPClientSpy()
        let remoteTransactionFeedService = RemoteTransactionsFeedService(client: client)
        let (sut, spy) = make_sut(transactionFeedService: remoteTransactionFeedService)

        sut.reloadTransactions(
            minTransactionTimestamp: minTransactionTimestamp,
            maxTransactionTimestamp: maxTransactionTimestamp
        )

        XCTAssertEqual(spy.isLoading, true)
    }

    func test_loadFeed_triggersAPICall_whichSuccessOrFailure_setsLoadStateToFalse() {
        let client = HTTPClientSpy()
        let remoteTransactionFeedService = RemoteTransactionsFeedService(client: client)
        let (sut, spy) = make_sut(transactionFeedService: remoteTransactionFeedService)

        sut.reloadTransactions(
            minTransactionTimestamp: minTransactionTimestamp,
            maxTransactionTimestamp: maxTransactionTimestamp
        )
        XCTAssertEqual(spy.isLoading, true)
        client.complete(withStatusCode: 400, data: MockData.any_data(
            for: MockData.FileName.badJSON.rawValue,
            fromBundle: MockNetworkingPackageBundleAccessor.bundle
        ))
        XCTAssertEqual(spy.isLoading, false)

        sut.reloadTransactions(
            minTransactionTimestamp: minTransactionTimestamp,
            maxTransactionTimestamp: maxTransactionTimestamp
        )
        XCTAssertEqual(spy.isLoading, true)
        client.complete(withStatusCode: 200, data: Data())
        XCTAssertEqual(spy.isLoading, false)
    }

    func test_loadFeed_triggersAPICall_whichOnError_returnsError() {
        let client = HTTPClientSpy()
        let remoteTransactionFeedService = RemoteTransactionsFeedService(client: client)
        let (sut, spy) = make_sut(transactionFeedService: remoteTransactionFeedService)
        let expectedError = NSError(domain: "Any Error", code: 404)

        sut.reloadTransactions(
            minTransactionTimestamp: minTransactionTimestamp,
            maxTransactionTimestamp: maxTransactionTimestamp
        )
        client.complete(with: expectedError)

        XCTAssertNotNil(spy.error)
    }

    func test_loadFeed_triggersAPICall_whichOnSuccess_returnsAccounts() {
        let client = HTTPClientSpy()
        let remoteTransactionFeedService = RemoteTransactionsFeedService(client: client)
        let (sut, spy) = make_sut(transactionFeedService: remoteTransactionFeedService)

        let accountsResponseData = MockData.any_data(
            for: MockData.FileName.transactions.rawValue,
            fromBundle: MockNetworkingPackageBundleAccessor.bundle
        )
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(
            .jsonDateTimeFormatter
        )
        sut.reloadTransactions(
            minTransactionTimestamp: minTransactionTimestamp,
            maxTransactionTimestamp: maxTransactionTimestamp
        )
        client.complete(withStatusCode: 200, data: accountsResponseData)

        XCTAssertEqual(spy.didSuccessfulyLoadTransactions, true)
        XCTAssertEqual(spy.error, .none)
    }
}

// MARK: - Make SUT
extension TransactionsFeedViewModelTests {
    private func make_sut(
        transactionFeedService: RemoteTransactionsFeedService,
        title: String = "Feed"
    ) -> (sut: TransactionsFeedViewModel, spy: SpyTransactionsFeed) {
        let coordinator = SpyAccountsSavingsCoordinator()
        let accountResponseData = MockData.any_data(
            for: MockData.FileName.account.rawValue,
            fromBundle: MockNetworkingPackageBundleAccessor.bundle
        )
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(
            .jsonDateTimeFormatter
        )
        
        let account = try! decoder.decode(
            TestAccount.self,
            from: accountResponseData
        )
        
        let sut = TransactionsFeedViewModel(
            with: account.toModel(),
            service: transactionFeedService,
            coordinator: coordinator,
            title: title)
        
        trackForMemoryLeaks(sut)

        let spy = SpyTransactionsFeed(viewModel: sut)
        trackForMemoryLeaks(spy)

        return (sut, spy)
    }
}
