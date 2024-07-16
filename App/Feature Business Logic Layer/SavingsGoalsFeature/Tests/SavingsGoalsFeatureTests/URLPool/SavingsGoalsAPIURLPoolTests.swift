//
//  URLPoolTests.swift
//  SavingsGoalsFeatureTests
//
//  Created by TM.Dev on 07/06/2021.
//

import XCTest
import CoreFoundational
import CoreNetworking
import CoreTesting
@testable import SavingsGoalsFeature

final class URLPoolTests: SavingsGoalsAPIURLPoolTest {
    let expectedScheme = "https"
    let expectedHost = "api-sandbox.starlingbank.com"
    let defaultPath = "/api/v2/"
    let accessToken = "a1b23cd4e5"
    let accountUID = "fb208978-a9c9-43b7-b02a-04131951aa01"
    
    override func setUp() {
        super.setUp()
        Self.resetUserDefaults()
        setupAuthentication()
    }
}
 
// MARK: - Savings Goal Feed Request Test
extension URLPoolTests {
    func test_savingsGoalFeedRequest_configuresSavingsGoalFeedRequestCorrectly() {
        let suffix = "account/\(accountUID)/savings-goals"
        let expectedUrlAbsoluteString = fullURL(withPathSuffix: suffix)
        let request = URLPool.savingsGoalFeedRequest(forAccountUID: accountUID)
        
        assert(request: request, urlAbsoluteString: expectedUrlAbsoluteString, httpMethod: .get)
        assert(request: request, hasExpectedBearerToken: accessToken)
    }
}
    
// MARK: - Save Savings Goal Request Test
extension URLPoolTests {
    func test_saveSavingsGoalRequest_configuresSaveSavingsGoalRequestCorrectly() throws {
        let name = "NYC Trip"
        let target = GoalTarget(currency: "gbp", minorUnits: 2000)
        let suffix = "account/\(accountUID)/savings-goals"
        let expectedUrlAbsoluteString = fullURL(withPathSuffix: suffix)
        let request = try URLPool.saveSavingsGoalRequest(forAccountUID: accountUID, goalName: name, target: target)
        
        assert(request: request, urlAbsoluteString: expectedUrlAbsoluteString, httpMethod: .put)
        assert(request: request, hasExpectedBearerToken: accessToken)
        assert(request: request, hasExpectedContentType: .json)
        
        guard let body = request.httpBody else {
            XCTFail("Expected `saveSavingsGoalRequest` to have a HTTP body containing a `SaveableSavingsGoal`")
            return
        }
        let returnedSaveableSavingsGoal = try JSONDecoder().decode(TestSaveableSavingsGoal.self, from: body)
        XCTAssertEqual(returnedSaveableSavingsGoal.name, name)
        XCTAssertEqual(returnedSaveableSavingsGoal.currency, target.currency)
        XCTAssertEqual(returnedSaveableSavingsGoal.target.currency, target.currency)
        XCTAssertEqual(returnedSaveableSavingsGoal.target.minorUnits, target.minorUnits)
        XCTAssertEqual(returnedSaveableSavingsGoal.base64EncodedPhoto, nil)
    }
}

// MARK: - Add To Savings Goal Request Test
extension URLPoolTests {
    func test_addToSavingsGoalRequest_configuresSaveSavingsGoalRequestCorrectly() throws {
        let transferGoalsUUID = UUID().uuidString
        let savingsGoalUID = "a9c9-b02a-04131951aa01-a9c9"
        let suffix = "account/\(accountUID)/savings-goals/\(savingsGoalUID)/add-money/\(transferGoalsUUID )"
        let expectedUrlAbsoluteString = fullURL(withPathSuffix: suffix)
        
        let amountSaved = RemoteTotalSaved(currency: "gbp", minorUnits: 2000)
        let request = try URLPool.add(amount: amountSaved, forAccountUID: accountUID, intoSavingsGoalUid: savingsGoalUID, transferGoalsUUID: transferGoalsUUID)
        
        assert(request: request, urlAbsoluteString: expectedUrlAbsoluteString, httpMethod: .put)
        assert(request: request, hasExpectedBearerToken: accessToken)
        assert(request: request, hasExpectedContentType: .json)
        
        guard let body = request.httpBody else {
            XCTFail("Expected `saveSavingsGoalRequest` to have a HTTP body containing a `SaveableSavingsGoal`")
            return
        }
        let returnedTotalSaved = try JSONDecoder().decode(RemoteTotalToSave.self, from: body)
        XCTAssertEqual(returnedTotalSaved.amount.currency, amountSaved.currency)
        XCTAssertEqual(returnedTotalSaved.amount.minorUnits, amountSaved.minorUnits)
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
    
    private struct TestSaveableSavingsGoal: Decodable {
        let name: String
        let currency: String
        let target: TestGoalTarget
        let base64EncodedPhoto: String?
    }
    
    private struct RemoteTotalToSave: Codable {
        let amount: RemoteTotalSaved
    }
}
