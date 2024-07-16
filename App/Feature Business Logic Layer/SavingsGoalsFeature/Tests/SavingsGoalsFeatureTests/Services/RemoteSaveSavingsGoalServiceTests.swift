//
//  RemoteSaveSavingsGoalsFeedServiceTests.swift
//  SavingsGoalsFeatureTests
//
//  Created by TM.Dev on 09/06/2021.
//

import XCTest
import CoreTesting
import CoreNetworking
import MockNetworking
@testable import SavingsGoalsFeature

final class RemoteSaveSavingsGoalServiceTests: XCTestCase {
    let accountUID = "fb208978-a9c9-43b7-b02a-04131951aa01"
    let goalName = "NYC Trip"
    let target = GoalTarget(currency: "gbp", minorUnits: 2000)
    
    func test_save_onSuccessWithNon200Code_returnsError() {
        let (sut, client) = make_sut()

        var returnedError: RemoteSaveSavingsGoalService.Error?
        let exp = expectation(description: "Wait for save completion")
        sut.saveSavingsGoalRequestForAccount(
            withUID: accountUID,
            goalName: goalName,
            target: target) { result in
            switch result {
            case .success:
                XCTFail("Expected for Save to fail as StatusCode: 100 should result in a failure")
            case .failure(let error as RemoteSaveSavingsGoalService.Error):
                returnedError = error
                exp.fulfill()
            case .failure:
                XCTFail("Expected for Save to fail with RemoteSaveSavingsGoalsFeedService.Error.invalidResponse error")
            }
        }

        client.complete(withStatusCode: 100, data: .init())
        wait(for: [exp], timeout: 1.0)

        XCTAssertEqual(returnedError, .invalidResponse)
    }

    func test_save_onSuccessWithNonInvalidData_returnsError() {
        let (sut, client) = make_sut()

        var returnedError: RemoteSaveSavingsGoalService.Error?
        let exp = expectation(description: "Wait for save completion")
        sut.saveSavingsGoalRequestForAccount(
            withUID: accountUID,
            goalName: goalName,
            target: target) { result in
            switch result {
            case .success:
                XCTFail("Expected for Save to fail as StatusCode: 100 should result in a failure")
            case .failure(let error as RemoteSaveSavingsGoalService.Error):
                returnedError = error
                exp.fulfill()
            case .failure:
                XCTFail("Expected for Save to fail with RemoteAccountsFeedService.Error.invalidData error")
            }
        }

        client.complete(withStatusCode: 200, data: MockData.any_data(
            for: MockData.FileName.badJSON.rawValue,
            fromBundle: MockNetworkingPackageBundleAccessor.bundle
        ))
        wait(for: [exp], timeout: 1.0)

        XCTAssertEqual(returnedError, .invalidData)
    }

    func test_save_onSuccess_returnsSavedSavingsGoal() {
        let (sut, client) = make_sut()

        var returnedSavingsGoal: SavedSavingsGoal?
        let exp = expectation(description: "Wait for Save completion")
        sut.saveSavingsGoalRequestForAccount(
            withUID: accountUID,
            goalName: goalName,
            target: target) { result in
            switch result {
            case .success(let savedSavingGoal):
                returnedSavingsGoal = savedSavingGoal
                exp.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }

        let data = MockData.any_data(
            for: MockData.FileName.savedSavingsGoal.rawValue,
            fromBundle: MockNetworkingPackageBundleAccessor.bundle
        )
        let testSavedSavingsGoal = try! JSONDecoder().decode(TestSavedSavingsGoal.self, from: data)
        client.complete(withStatusCode: 200, data: data)
        wait(for: [exp], timeout: 1.0)

        XCTAssertEqual(returnedSavingsGoal, testSavedSavingsGoal.toModel())
    }
    
    func test_save_onSuccess_withUnscessfullResponse_returnsReturnsSavedSavingsGoalWithFailedState() {
        let (sut, client) = make_sut()

        var returnedError: RemoteSaveSavingsGoalService.Error?
        let exp = expectation(description: "Wait for save completion")
        sut.saveSavingsGoalRequestForAccount(
            withUID: accountUID,
            goalName: goalName,
            target: target) { result in
            switch result {
            case .success:
                XCTFail("Expected for Save to fail as `RemoteSaveSavingsGoalService.failedToSave`")
            case .failure(let error as RemoteSaveSavingsGoalService.Error):
                returnedError = error
                exp.fulfill()
            case .failure(_):
                XCTFail("Expected for Save to fail as `RemoteSaveSavingsGoalService.failedToSave`")
            }
        }

        let data = MockData.any_data(
            for: MockData.FileName.savedSavingsGoalFailed.rawValue,
            fromBundle: MockNetworkingPackageBundleAccessor.bundle
        )
        client.complete(withStatusCode: 200, data: data)

        wait(for: [exp], timeout: 1.0)

        XCTAssertEqual(returnedError, .failedToSave)
    }

    func test_save_onFailure_returnsError() {
        let (sut, client) = make_sut()

        var returnedError: Error?
        let exp = expectation(description: "Wait for save completion")
        sut.saveSavingsGoalRequestForAccount(
            withUID: accountUID,
            goalName: goalName,
            target: target) { result in
            switch result {
            case .success:
                XCTFail("Expected for Save to fail as StatusCode: 100 should result in a failure")
            case .failure(let error):
                returnedError = error
                exp.fulfill()
            }
        }

        let clientError = NSError(domain: "Test", code: 0)
        client.complete(with: clientError)

        wait(for: [exp], timeout: 1.0)

        XCTAssertNotNil(returnedError)
    }
}

// MARK: - Make Sut
extension RemoteSaveSavingsGoalServiceTests {
    private func make_sut() -> (sut: RemoteSaveSavingsGoalService, client: HTTPClientSpy)  {
        let client = HTTPClientSpy()
        let sut = RemoteSaveSavingsGoalService(client: client)
        trackForMemoryLeaks(sut)
        return (sut, client)
    }
}

