//
//  AccountsFeedViewModelTests.swift
//  AccountsFeatureTests
//
//  Created by TM.Dev on 06/06/2021.
//

import XCTest
import CoreFoundational
import CoreNetworking
import MockNetworking
import AccountsFeature

final class AccountsFeedViewModelTests: AccountsFeedViewModelTest {
    func test_init_setsInitialVariablesCorrectly() {
        let title = "Accounts Feed"
        let client = HTTPClientSpy()
        let remoteAccountsFeedService = RemoteAccountsFeedService(client: client)
        let (sut, _) = make_sut(accountsFeedService: remoteAccountsFeedService, title: title)

        XCTAssertEqual(sut.title, title)
        XCTAssertNotNil(sut.accountsFeedService as? RemoteAccountsFeedService)
    }

    func test_loadFeed_setsLoadStateToTrue() {
        let client = HTTPClientSpy()
        let remoteAccountsFeedService = RemoteAccountsFeedService(client: client)
        let (sut, spy) = make_sut(accountsFeedService: remoteAccountsFeedService)

        sut.loadFeed()

        XCTAssertEqual(spy.isLoading, true)
    }

    func test_loadFeed_triggersAPICall_whichSuccessOrFailure_setsLoadStateToFalse() {
        let client = HTTPClientSpy()
        let remoteAccountsFeedService = RemoteAccountsFeedService(client: client)
        let (sut, spy) = make_sut(accountsFeedService: remoteAccountsFeedService)

        sut.loadFeed()
        XCTAssertEqual(spy.isLoading, true)
        client.complete(withStatusCode: 400, data: MockData.any_data(
            for: MockData.FileName.badJSON.rawValue,
            fromBundle: MockNetworkingPackageBundleAccessor.bundle
        ))
        XCTAssertEqual(spy.isLoading, false)

        sut.loadFeed()
        XCTAssertEqual(spy.isLoading, true)
        client.complete(withStatusCode: 200, data: Data())
        XCTAssertEqual(spy.isLoading, false)
    }

    func test_loadFeed_triggersAPICall_whichOnError_returnsError() {
        let client = HTTPClientSpy()
        let remoteAccountsFeedService = RemoteAccountsFeedService(client: client)
        let (sut, spy) = make_sut(accountsFeedService: remoteAccountsFeedService)
        let expectedError = NSError(domain: "Any Error", code: 404)

        sut.loadFeed()
        client.complete(with: expectedError)

        XCTAssertNotNil(spy.error)
    }

    func test_loadFeed_triggersAPICall_whichOnSuccess_returnsAccounts() {
        let client = HTTPClientSpy()
        let remoteAccountsFeedService = RemoteAccountsFeedService(client: client)
        let (sut, spy) = make_sut(accountsFeedService: remoteAccountsFeedService)

        let accountsResponseData = MockData.any_data(
            for: MockData.FileName.accounts.rawValue,
            fromBundle: MockNetworkingPackageBundleAccessor.bundle
        )
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(
            .jsonDateTimeFormatter
        )
        
        let expectedFeed = try! decoder.decode(
            TestAccountFeed.self,
            from: accountsResponseData
        )
        sut.loadFeed()
        client.complete(withStatusCode: 200, data: accountsResponseData)

        XCTAssertEqual(spy.accounts, expectedFeed.accounts.toModels())
        XCTAssertEqual(spy.error, .none)
    }
}

// MARK: - Make SUT
extension AccountsFeedViewModelTests {
    private func make_sut(
        accountsFeedService: RemoteAccountsFeedService,
        title: String = "Feed"
    ) -> (sut: AccountsFeedViewModel, spy: SpyAccountsFeed) {
        let coordinator = SpyAccountsCoordinator()
        let sut = AccountsFeedViewModel(
            accountsFeedService: accountsFeedService,
            title: title, 
            coordinator: coordinator
        )
        trackForMemoryLeaks(sut)

        let spy = SpyAccountsFeed(viewModel: sut)
        trackForMemoryLeaks(spy)

        return (sut, spy)
    }
}
