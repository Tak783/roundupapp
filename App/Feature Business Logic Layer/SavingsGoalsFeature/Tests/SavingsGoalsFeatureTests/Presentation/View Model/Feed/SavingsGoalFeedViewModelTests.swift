//
//  SavingsGoalFeedViewModelTests.swift
//  SavingsGoalsFeatureTests
//
//  Created by TM.Dev on 07/06/2021.
//

import XCTest
import CoreFoundational
import CoreTesting
import CoreNetworking
import MockNetworking
import SavingsGoalsFeature

final class SavingsGoalFeedViewModelTests: SavingsGoalFeedViewModelTest {
    let accountUID = "fb208978-a9c9-43b7-b02a-04131951aa01"
    let client = HTTPClientSpy()
    
    func test_init_setsInitialVariablesCorrectly() {
        let title = "Savings Goals"
        let remoteSavingsGoalsFeedService = RemoteSavingsGoalsFeedService(client: client)
        let (sut, _) = make_sut(
            savingsGoalsFeedService: remoteSavingsGoalsFeedService,
            accountUID: accountUID,
            state: .normal
        )

        XCTAssertEqual(sut.title, title)
        XCTAssertEqual(sut.state, .normal)
        XCTAssertNotNil(sut.savingsGoalsFeedService as? RemoteSavingsGoalsFeedService)
        
        let (sut2, _) = make_sut(savingsGoalsFeedService: remoteSavingsGoalsFeedService, accountUID: accountUID, state: .goalSelection)

        XCTAssertEqual(sut2.title, title)
        XCTAssertEqual(sut2.state, .goalSelection)
        XCTAssertNotNil(sut2.savingsGoalsFeedService as? RemoteSavingsGoalsFeedService)
    }

    func test_loadFeed_setsLoadStateToTrue() {
        let remoteSavingsGoalsFeedService = RemoteSavingsGoalsFeedService(client: client)
        let (sut, spy) = make_sut(savingsGoalsFeedService: remoteSavingsGoalsFeedService, accountUID: accountUID)

        sut.loadFeed()

        XCTAssertEqual(spy.isLoading, true)
    }

    func test_loadFeed_triggersAPICall_whichSuccessOrFailure_setsLoadStateToFalse() {
        let remoteSavingsGoalsFeedService = RemoteSavingsGoalsFeedService(client: client)
        let (sut, spy) = make_sut(savingsGoalsFeedService: remoteSavingsGoalsFeedService, accountUID: accountUID)

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
        let remoteSavingsGoalsFeedService = RemoteSavingsGoalsFeedService(client: client)
        let (sut, spy) = make_sut(savingsGoalsFeedService: remoteSavingsGoalsFeedService, accountUID: accountUID)
        let expectedError = NSError(domain: "Any Error", code: 404)

        sut.loadFeed()
        client.complete(with: expectedError)

        XCTAssertNotNil(spy.error)
    }

    func test_loadFeed_triggersAPICall_whichOnSuccess_returnsAccounts() {
        let remoteSavingsGoalsFeedService = RemoteSavingsGoalsFeedService(client: client)
        let (sut, spy) = make_sut(savingsGoalsFeedService: remoteSavingsGoalsFeedService, accountUID: accountUID)

        let accountsResponseData = MockData.any_data(
            for: MockData.FileName.savingsGoals.rawValue,
            fromBundle: MockNetworkingPackageBundleAccessor.bundle
        )
        sut.loadFeed()
        client.complete(withStatusCode: 200, data: accountsResponseData)

        XCTAssertEqual(spy.didSuccessfullyLoadFeed, true)
        XCTAssertEqual(spy.error, .none)
    }
}

// MARK: - Make SUT
extension SavingsGoalFeedViewModelTests {
    private func make_sut(savingsGoalsFeedService: RemoteSavingsGoalsFeedService,
                          accountUID: String,
                          title: String = "Savings Goals",
                          state: SavingsGoalFeedViewModelViewState = .normal
    ) -> (
        sut: SavingsGoalFeedViewModel,
        spy: SpySavingsGoalsFeed
    ) {
        let coordinator = SpySelectSavingsGoalCoordinator()
        let sut = SavingsGoalFeedViewModel(
            with: accountUID,
            service: savingsGoalsFeedService,
            title: title,
            state: state, 
            coordinator: coordinator
        )
        trackForMemoryLeaks(sut)

        let spy = SpySavingsGoalsFeed(viewModel: sut)
        trackForMemoryLeaks(spy)

        return (sut, spy)
    }
}
