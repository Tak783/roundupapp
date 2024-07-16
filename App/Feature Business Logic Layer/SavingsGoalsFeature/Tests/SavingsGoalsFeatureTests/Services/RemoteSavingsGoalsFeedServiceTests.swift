//
//  RemoteSavingsGoalsFeedService.swift
//  SavingsGoalsFeatureTests
//
//  Created by TM.Dev on 07/06/2021.
//

import XCTest
import CoreTesting
import CoreNetworking
import MockNetworking
@testable import SavingsGoalsFeature

final class RemoteSavingsGoalsFeedServiceTests: XCTestCase {
    let accountUID = "fb208978-a9c9-43b7-b02a-04131951aa01"
    
    func test_load_onSuccessWithNon200Code_returnsError() {
        let (sut, client) = make_sut()

        var returnedError: RemoteSavingsGoalsFeedService.Error?
        let exp = expectation(description: "Wait for load completion")
        sut.loadSavingsGoalsforAccount(withUID: accountUID) { result in
            switch result {
            case .success:
                XCTFail("Expected for Load to fail as StatusCode: 100 should result in a failure")
            case .failure(let error as RemoteSavingsGoalsFeedService.Error):
                returnedError = error
                exp.fulfill()
            case .failure:
                XCTFail("Expected for Load to fail with RemoteAccountsFeedService.Error.invalidResponse error")
            }
        }

        client.complete(withStatusCode: 100, data: .init())
        wait(for: [exp], timeout: 1.0)

        XCTAssertEqual(returnedError, .invalidResponse)
    }

    func test_load_onSuccessWithNonInvalidData_returnsError() {
        let (sut, client) = make_sut()

        var returnedError: RemoteSavingsGoalsFeedService.Error?
        let exp = expectation(description: "Wait for load completion")
        sut.loadSavingsGoalsforAccount(withUID: accountUID) { result in
            switch result {
            case .success:
                XCTFail("Expected for Load to fail as StatusCode: 100 should result in a failure")
            case .failure(let error as RemoteSavingsGoalsFeedService.Error):
                returnedError = error
                exp.fulfill()
            case .failure:
                XCTFail("Expected for Load to fail with RemoteAccountsFeedService.Error.invalidData error")
            }
        }

        client.complete(withStatusCode: 200, data: MockData.any_data(
            for: MockData.FileName.badJSON.rawValue,
            fromBundle: MockNetworkingPackageBundleAccessor.bundle
        ))
        wait(for: [exp], timeout: 1.0)

        XCTAssertEqual(returnedError, .invalidData)
    }

    func test_load_onSuccess_returnsAccounts() {
        let (sut, client) = make_sut()

        var returnedSavingsGoals: [SavingsGoal]?
        let exp = expectation(description: "Wait for load completion")
        sut.loadSavingsGoalsforAccount(withUID: accountUID) { result in
            switch result {
            case .success(let accounts):
                returnedSavingsGoals = accounts
                exp.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }

        let data = MockData.any_data(
            for: MockData.FileName.savingsGoals.rawValue,
            fromBundle: MockNetworkingPackageBundleAccessor.bundle
        )
        let expectedFeed = try! JSONDecoder().decode(TestSavingsGoalFeed.self, from: data)
        client.complete(withStatusCode: 200, data: data)
        wait(for: [exp], timeout: 1.0)

        XCTAssertEqual(returnedSavingsGoals, expectedFeed.savingsGoalList.toModels())
    }

    func test_load_onFailure_returnsError() {
        let (sut, client) = make_sut()

        var returnedError: Error?
        let exp = expectation(description: "Wait for load completion")
        sut.loadSavingsGoalsforAccount(withUID: accountUID) { result in
            switch result {
            case .success:
                XCTFail("Expected for Load to fail as StatusCode: 100 should result in a failure")
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
extension RemoteSavingsGoalsFeedServiceTests {
    private func make_sut() -> (sut: RemoteSavingsGoalsFeedService, client: HTTPClientSpy)  {
        let client = HTTPClientSpy()
        let sut = RemoteSavingsGoalsFeedService(client: client)
        trackForMemoryLeaks(sut)
        return (sut, client)
    }
}
