//
//  RemoteAddMoneyToSavingsGoalsServiceTests.swift
//  SavingsGoalsFeatureTests
//
//  Created by TM.Dev on 09/06/2021.
//

import XCTest
import CoreTesting
import CoreNetworking
import MockNetworking
@testable import SavingsGoalsFeature

final class RemoteAddMoneyToSavingsGoalsServiceTests: XCTestCase {
    let accountUID = "fb208978-a9c9-43b7-b02a-04131951aa01"
    let savingsGoalUID = "fb208978-a9c9-43b7-b02a-04131951aa01"
    let currency = "gbp"
    let amount = 2000.00
    
    func test_add_onSuccessWithNon200Code_returnsError() {
        let (sut, client) = make_sut()

        var returnedError: RemoteAddMoneyToSavingsGoalsService.Error?
        let exp = expectation(description: "Wait for save completion")
        sut.add(amount: amount, intoSavingsGoalUid: savingsGoalUID) { result in
            switch result {
            case .success:
                XCTFail("Expected for Save to fail as StatusCode: 100 should result in a failure")
            case .failure(let error as RemoteAddMoneyToSavingsGoalsService.Error):
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

    func test_add_onSuccessWithNonInvalidData_returnsError() {
        let (sut, client) = make_sut()

        var returnedError: RemoteAddMoneyToSavingsGoalsService.Error?
        let exp = expectation(description: "Wait for save completion")
        sut.add(amount: amount, intoSavingsGoalUid: savingsGoalUID) { result in
            switch result {
            case .success:
                XCTFail("Expected for Save to fail as StatusCode: 100 should result in a failure")
            case .failure(let error as RemoteAddMoneyToSavingsGoalsService.Error):
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

    func test_add_onSuccess_withSucessfullResponse_returnsSavingsGoalUpdateSucessResult() {
        let (sut, client) = make_sut()

        var returnedSavingsGoal: SavingsGoalAddedTo?
        let exp = expectation(description: "Wait for Save completion")
        sut.add(amount: amount, intoSavingsGoalUid: savingsGoalUID) { result in
            switch result {
            case .success(let savedSavingGoal):
                returnedSavingsGoal = savedSavingGoal
                exp.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }

        let data = MockData.any_data(
            for: MockData.FileName.savingsGoalAddedTo.rawValue,
            fromBundle: MockNetworkingPackageBundleAccessor.bundle
        )
        let expectedTestRemoteTotalSaved = try! JSONDecoder().decode(TestSavingsGoalAddedTo.self, from: data)
        client.complete(withStatusCode: 200, data: data)
        wait(for: [exp], timeout: 1.0)

        XCTAssertEqual(returnedSavingsGoal?.transferUid, expectedTestRemoteTotalSaved.transferUid)
    }
    
    func test_add_onSuccess_withUnscessfullResponse_returnsReturnsSavingsGoalUpdateWithFailedState() {
        let (sut, client) = make_sut()

        var returnedError: RemoteAddMoneyToSavingsGoalsService.Error?
        let exp = expectation(description: "Wait for save completion")
        sut.add(amount: amount, intoSavingsGoalUid: savingsGoalUID) { result in
            switch result {
            case .success:
                XCTFail("Expected for Save to fail as `RemoteAddMoneyToSavingsGoalsService.failedToSave`")
            case .failure(let error as RemoteAddMoneyToSavingsGoalsService.Error):
                returnedError = error
                exp.fulfill()
            case .failure(_):
                XCTFail("Expected for Save to fail as `RemoteAddMoneyToSavingsGoalsService.failedToSave`")
            }
        }

        let data = MockData.any_data(
            for: MockData.FileName.savingsGoalAddedToFailed.rawValue,
            fromBundle: MockNetworkingPackageBundleAccessor.bundle
        )
        client.complete(withStatusCode: 200, data: data)
        wait(for: [exp], timeout: 1.0)

        XCTAssertEqual(returnedError, .failedToSave)
    }

    func test_add_onFailure_returnsError() {
        let (sut, client) = make_sut()

        var returnedError: Error?
        let exp = expectation(description: "Wait for save completion")
        sut.add(amount: amount, intoSavingsGoalUid: savingsGoalUID) { result in
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
extension RemoteAddMoneyToSavingsGoalsServiceTests {
    private func make_sut() -> (sut: RemoteAddMoneyToSavingsGoalsService, client: HTTPClientSpy)  {
        let client = HTTPClientSpy()
        let sut = RemoteAddMoneyToSavingsGoalsService(
            client: client,
            forAccountUID: accountUID,
            currency: currency
        )
        trackForMemoryLeaks(sut)
        return (sut, client)
    }
}
