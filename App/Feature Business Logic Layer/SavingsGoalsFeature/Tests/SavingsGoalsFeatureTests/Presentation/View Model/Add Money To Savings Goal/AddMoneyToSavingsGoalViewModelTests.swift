//
//  AddMoneyToSavingsGoalViewModelTests.swift
//  SavingsGoalsFeatureTests
//
//  Created by TM.Dev on 10/06/2021.
//

import XCTest
import CoreFoundational
import CoreTesting
import CoreNetworking
import MockNetworking
import SavingsGoalsFeature

final class AddMoneyToSavingsGoalViewModelTests: XCTestCase {
    let accountUID = "fb208978-a9c9-43b7-b02a-04131951aa01"
    let savingsGoalUID = "fb208978-a9c9-43b7-b02a-04131951aa01"
    let currency = "GBP"
    let amount = 2000.00
    let client = HTTPClientSpy()
    
    func test_init_setsInitialVariablesCorrectly() {
        let remoteAddMoneyToSavingsGoalsService = RemoteAddMoneyToSavingsGoalsService(client: client, forAccountUID: accountUID, currency: accountUID)
        let (sut, _) = make_sut(addMoneyToSavingsGoalsService: remoteAddMoneyToSavingsGoalsService, accountUID: accountUID)

        XCTAssertNotNil(sut.addMoneyToSavingsGoalsService as? RemoteAddMoneyToSavingsGoalsService)
    }

    func test_addToSavingsGoal_setsLoadStateToTrue() {
        let remoteAddMoneyToSavingsGoalsService = RemoteAddMoneyToSavingsGoalsService(
            client: client,
            forAccountUID: accountUID,
            currency: accountUID
        )
        let (sut, spy) = make_sut(
            addMoneyToSavingsGoalsService: remoteAddMoneyToSavingsGoalsService,
            accountUID: accountUID
        )

        sut.add(amount: amount, intoSavingsGoalUid: savingsGoalUID)

        XCTAssertEqual(spy.isLoading, true)
    }

    func test_addToSavingsGoal_triggersAPICall_whichSuccessOrFailure_setsLoadStateToFalse() {
        let remoteAddMoneyToSavingsGoalsService = RemoteAddMoneyToSavingsGoalsService(
            client: client,
            forAccountUID: accountUID,
            currency: accountUID
        )
        let (sut, spy) = make_sut(
            addMoneyToSavingsGoalsService: remoteAddMoneyToSavingsGoalsService,
            accountUID: accountUID
        )

        sut.add(amount: amount, intoSavingsGoalUid: savingsGoalUID)
        XCTAssertEqual(spy.isLoading, true)
        client.complete(
            withStatusCode: 400,
            data: MockData.any_data(
                for: MockData.FileName.badJSON.rawValue,
                fromBundle: MockNetworkingPackageBundleAccessor.bundle
            )
        )
        XCTAssertEqual(spy.isLoading, false)

        sut.add(amount: amount, intoSavingsGoalUid: savingsGoalUID)
        XCTAssertEqual(spy.isLoading, true)
        client.complete(withStatusCode: 200, data: Data())
        XCTAssertEqual(spy.isLoading, false)
    }

    func test_saveSavingsGoal_triggersAPICall_whichOnError_returnsError() {
        let remoteAddMoneyToSavingsGoalsService = RemoteAddMoneyToSavingsGoalsService(
            client: client,
            forAccountUID: accountUID,
            currency: accountUID
        )
        let (sut, spy) = make_sut(
            addMoneyToSavingsGoalsService: remoteAddMoneyToSavingsGoalsService, 
            accountUID: accountUID
        )
        let expectedError = NSError(domain: "Any Error", code: 404)

        sut.add(amount: amount, intoSavingsGoalUid: savingsGoalUID)
        client.complete(with: expectedError)

        XCTAssertNotNil(spy.error)
    }

    func test_addToSavingsGoal_triggersAPICall_whichOnSuccess_savesGoal() throws {
        let remoteAddMoneyToSavingsGoalsService = RemoteAddMoneyToSavingsGoalsService(
            client: client,
            forAccountUID: accountUID,
            currency: accountUID
        )
        let (sut, spy) = make_sut(
            addMoneyToSavingsGoalsService: remoteAddMoneyToSavingsGoalsService,
            accountUID: accountUID
        )

        let data = MockData.any_data(
            for: MockData.FileName.savingsGoalAddedTo.rawValue,
            fromBundle: MockNetworkingPackageBundleAccessor.bundle
        )
        let _ = try JSONDecoder().decode(
            TestSavingsGoalAddedTo.self,
            from: data
        )
        sut.add(amount: amount, intoSavingsGoalUid: savingsGoalUID)
        client.complete(withStatusCode: 200, data: data)

        XCTAssertEqual(spy.didSave, true)
        XCTAssertEqual(spy.error, .none)
    }
}

// MARK: - Make SUT
extension AddMoneyToSavingsGoalViewModelTests {
    private func make_sut(
        addMoneyToSavingsGoalsService: RemoteAddMoneyToSavingsGoalsService,
        accountUID: String
    ) -> (sut: AddMoneyToSavingsGoalViewModel, spy: SpyAddMoneyToSavingsGoalsFeed) {
        let sut = AddMoneyToSavingsGoalViewModel(
            service: addMoneyToSavingsGoalsService
        )
        trackForMemoryLeaks(sut)

        let spy = SpyAddMoneyToSavingsGoalsFeed(viewModel: sut)
        trackForMemoryLeaks(spy)

        return (sut, spy)
    }
}
