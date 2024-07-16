//
//  SavingsGoalFeedViewModelTestSpec.swift
//  SavingsGoalsFeatureTests
//
//  Created by TM.Dev on 07/06/2021.
//

import XCTest

protocol SavingsGoalFeedViewModelTestSpec {
    func test_loadFeed_setsLoadStateToTrue()
    func test_loadFeed_triggersAPICall_whichSuccessOrFailure_setsLoadStateToFalse()
    func test_loadFeed_triggersAPICall_whichOnError_returnsError()
    func test_loadFeed_triggersAPICall_whichOnSuccess_returnsAccounts()
}

typealias SavingsGoalFeedViewModelTest = XCTestCase & SavingsGoalFeedViewModelTestSpec
