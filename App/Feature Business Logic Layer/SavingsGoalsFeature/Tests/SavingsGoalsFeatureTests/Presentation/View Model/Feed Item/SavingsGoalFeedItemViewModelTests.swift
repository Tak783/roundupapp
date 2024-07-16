//
//  SavingsGoalFeedItemViewModelTests.swift
//  SavingsGoalsFeatureTests
//
//  Created by TM.Dev on 07/06/2021.
//

import XCTest
import CoreFoundational
import CoreNetworking
import MockNetworking
import SavingsGoalsFeature

final class SavingsGoalFeedItemViewModelTests: XCTestCase {
    func test_init_setsInitialVariablesCorrectly() {
        let data = MockData.any_data(
            for: MockData.FileName.savingsGoal.rawValue,
            fromBundle: MockNetworkingPackageBundleAccessor.bundle
        )
        do {
            let savingsGoal = try JSONDecoder().decode(TestSavingsGoal.self, from: data)
            let sut = make_sut(with: savingsGoal.toModel())

            XCTAssertEqual(sut.id, savingsGoal.savingsGoalUid)
            XCTAssertEqual(sut.name, savingsGoal.name)
            XCTAssertEqual(sut.target, "£1,000.00")
            XCTAssertEqual(sut.totalSaved, "£20.00")
            XCTAssertEqual(sut.savedPercentage, String(savingsGoal.savedPercentage) + "%")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}

// MARK: - Make SUT
extension SavingsGoalFeedItemViewModelTests {
    private func make_sut(with savingsGoal: SavingsGoal) -> SavingsGoalFeedItemViewModel {
        let sut = SavingsGoalFeedItemViewModel(with: savingsGoal)
        trackForMemoryLeaks(sut)
        return sut
    }
}
