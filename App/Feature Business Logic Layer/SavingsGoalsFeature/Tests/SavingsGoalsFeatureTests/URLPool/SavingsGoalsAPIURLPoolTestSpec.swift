//
//  SavingsGoalsAPIURLPoolTest.swift
//  SavingsGoalsFeatureTests
//
//  Created by TM.Dev on 07/06/2021.
//

import XCTest

typealias SavingsGoalsAPIURLPoolTest = XCTestCase & SavingsGoalsAPIURLPoolTestSpec

protocol SavingsGoalsAPIURLPoolTestSpec {
    func test_savingsGoalFeedRequest_configuresSavingsGoalFeedRequestCorrectly()
}
