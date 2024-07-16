//
//  SaveSavingsGoalViewModelTests.swift
//  SavingsGoalsFeatureTests
//
//  Created by TM.Dev on 09/06/2021.
//

import CoreFoundational
import CoreTesting
import CoreNetworking
import MockNetworking
import SavingsGoalsFeature
import XCTest

final class SaveSavingsGoalViewModelTests: XCTestCase {
    let accountUID = "fb208978-a9c9-43b7-b02a-04131951aa01"
    let goalName = "NYC Trip"
    let goalTarget = 2000.00
    
    func test_init_setsInitialVariablesCorrectly() {
        let client = HTTPClientSpy()
        let remoteSaveSavingsGoalService = RemoteSaveSavingsGoalService(client: client)
        let (sut, _) = make_sut(saveSavingsGoalService: remoteSaveSavingsGoalService, accountUID: accountUID)

        XCTAssertNotNil(sut.saveSavingsGoalService as? RemoteSaveSavingsGoalService)
    }

    func test_saveSavingsGoal_setsLoadStateToTrue() {
        let client = HTTPClientSpy()
        let remoteSaveSavingsGoalService = RemoteSaveSavingsGoalService(client: client)
        let (sut, spy) = make_sut(saveSavingsGoalService: remoteSaveSavingsGoalService, accountUID: accountUID)

        sut.saveSavingsGoal(withName: goalName, target: goalTarget)

        XCTAssertEqual(spy.isLoading, true)
    }

    func test_saveSavingsGoal_triggersAPICall_whichSuccessOrFailure_setsLoadStateToFalse() {
        let client = HTTPClientSpy()
        let remoteSaveSavingsGoalService = RemoteSaveSavingsGoalService(client: client)
        let (sut, spy) = make_sut(saveSavingsGoalService: remoteSaveSavingsGoalService, accountUID: accountUID)

        sut.saveSavingsGoal(withName: goalName, target: goalTarget)
        XCTAssertEqual(spy.isLoading, true)
        client.complete(withStatusCode: 400, data: MockData.any_data(
            for: MockData.FileName.badJSON.rawValue,
            fromBundle: MockNetworkingPackageBundleAccessor.bundle
        ))
        XCTAssertEqual(spy.isLoading, false)

        sut.saveSavingsGoal(withName: goalName, target: goalTarget)
        XCTAssertEqual(spy.isLoading, true)
        client.complete(withStatusCode: 200, data: Data())
        XCTAssertEqual(spy.isLoading, false)
    }

    func test_saveSavingsGoal_triggersAPICall_whichOnError_returnsError() {
        let client = HTTPClientSpy()
        let remoteSaveSavingsGoalService = RemoteSaveSavingsGoalService(client: client)
        let (sut, spy) = make_sut(saveSavingsGoalService: remoteSaveSavingsGoalService, accountUID: accountUID)
        let expectedError = NSError(domain: "Any Error", code: 404)

        sut.saveSavingsGoal(withName: goalName, target: goalTarget)
        client.complete(with: expectedError)

        XCTAssertNotNil(spy.error)
    }

    func test_saveSavingsGoal_triggersAPICall_whichOnSuccess_savesGoal() {
        let client = HTTPClientSpy()
        let remoteSaveSavingsGoalService = RemoteSaveSavingsGoalService(client: client)
        let (sut, spy) = make_sut(saveSavingsGoalService: remoteSaveSavingsGoalService, accountUID: accountUID)

        let data = MockData.any_data(
            for: MockData.FileName.savedSavingsGoal.rawValue,
            fromBundle: MockNetworkingPackageBundleAccessor.bundle
        )
        let _ = try! JSONDecoder().decode(TestSavedSavingsGoal.self, from: data)
        sut.saveSavingsGoal(withName: goalName, target: goalTarget)
        client.complete(withStatusCode: 200, data: data)

        XCTAssertEqual(spy.didSave, true)
        XCTAssertEqual(spy.error, .none)
    }
}

// MARK: - Make SUT
extension SaveSavingsGoalViewModelTests {
    private func make_sut(
        saveSavingsGoalService: RemoteSaveSavingsGoalService,
        accountUID: String
    ) -> (
        sut: SaveSavingsGoalViewModel,
        spy: SpySaveSavingsGoalsFeed
    ) {
        let coordinator = SpyAddNewSavingsGoalCoordinator()
        let sut = SaveSavingsGoalViewModel(
            with: accountUID,
            currencyCode: "GBP",
            service: saveSavingsGoalService,
            coordinator: coordinator
        )
        trackForMemoryLeaks(sut)

        let spy = SpySaveSavingsGoalsFeed(viewModel: sut)
        trackForMemoryLeaks(spy)

        return (sut, spy)
    }
}
