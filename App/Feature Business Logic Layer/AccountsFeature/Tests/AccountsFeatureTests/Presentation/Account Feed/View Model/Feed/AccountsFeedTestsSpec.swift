//
//  AccountsFeedTestsSpec.swift
//  AccountsFeatureTests
//
//  Created by TM.Dev on 06/06/2021.
//

import XCTest

protocol AccountsFeedTestsSpec {
    func test_loadFeed_setsLoadStateToTrue()
    func test_loadFeed_triggersAPICall_whichSuccessOrFailure_setsLoadStateToFalse()
    func test_loadFeed_triggersAPICall_whichOnError_returnsError()
    func test_loadFeed_triggersAPICall_whichOnSuccess_returnsAccounts()
}

typealias AccountsFeedViewModelTest = XCTestCase & AccountsFeedTestsSpec
