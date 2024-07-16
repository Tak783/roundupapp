//
//  RemoteTransactionsFeedServiceTests.swift
//  AccountsFeatureTests
//
//  Created by TM.Dev on 06/06/2021.
//

import XCTest
import CoreTesting
import CoreNetworking
import MockNetworking
import AccountsFeature

final class RemoteTransactionsFeedServiceTests: TransactionsFeedServiceTest {
    let accountUID = "fb208978-a9c9-43b7-b02a-04131951aa01"
    let categoryUID = "fb208978-a9c9-43b7-b02a-04131951aa01"
    
    // TODO: Add date picker
    let minTransactionTimestamp = DateFormatter.jsonDateTimeFormatter.date(
        from: "2024-06-30T12:34:56.000Z"
    )!
    let maxTransactionTimestamp = DateFormatter.jsonDateTimeFormatter.date(
        from:"2024-07-30T12:34:56.000Z"
    )!
    
    func test_loadTransactions_onSuccessWithNon200Code_returnsError() {
        let (sut, client) = make_sut()

        var returnedError: RemoteTransactionsFeedService.Error?
        let exp = expectation(description: "Wait for load completion")
        sut.loadTransactions(forAccountUID: accountUID,
                             categoryUID: categoryUID,
                             minTransactionTimestamp: minTransactionTimestamp,
                             maxTransactionTimestamp: maxTransactionTimestamp) { result in
            switch result {
            case .success:
                XCTFail("Expected for Load to fail as StatusCode: 100 should result in a failure")
            case .failure(let error as RemoteTransactionsFeedService.Error):
                returnedError = error
                exp.fulfill()
            case .failure:
                XCTFail("Expected for Load to fail with RemoteAccountsService.Error.invalidResponse error")
            }
        }

        client.complete(withStatusCode: 100, data: .init())
        wait(for: [exp], timeout: 1.0)

        XCTAssertEqual(returnedError, .invalidResponse)
    }

    func test_loadTransactions_onSuccessWithNonInvalidData_returnsError() {
        let (sut, client) = make_sut()

        var returnedError: RemoteTransactionsFeedService.Error?
        let exp = expectation(description: "Wait for load completion")
        sut.loadTransactions(forAccountUID: accountUID,
                             categoryUID: categoryUID,
                             minTransactionTimestamp: minTransactionTimestamp,
                             maxTransactionTimestamp: maxTransactionTimestamp) { result in
            switch result {
            case .success:
                XCTFail("Expected for Load to fail as StatusCode: 100 should result in a failure")
            case .failure(let error as RemoteTransactionsFeedService.Error):
                returnedError = error
                exp.fulfill()
            case .failure:
                XCTFail("Expected for Load to fail with RemoteAccountsService.Error.invalidData error")
            }
        }

        client.complete(withStatusCode: 200, data: MockData.any_data(
            for: MockData.FileName.badJSON.rawValue,
            fromBundle: MockNetworkingPackageBundleAccessor.bundle
        ))
        wait(for: [exp], timeout: 1.0)

        XCTAssertEqual(returnedError, .invalidData)
    }

    func test_loadTransactions_onFailure_returnsError() {
        let (sut, client) = make_sut()

        var returnedError: Error?
        let exp = expectation(description: "Wait for load completion")
        sut.loadTransactions(forAccountUID: accountUID,
                             categoryUID: categoryUID,
                             minTransactionTimestamp: minTransactionTimestamp,
                             maxTransactionTimestamp: maxTransactionTimestamp) { result in
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
extension RemoteTransactionsFeedServiceTests {
    private func make_sut() -> (sut: RemoteTransactionsFeedService, client: HTTPClientSpy)  {
        let client = HTTPClientSpy()
        let sut = RemoteTransactionsFeedService(client: client)
        trackForMemoryLeaks(sut)
        return (sut, client)
    }
}
