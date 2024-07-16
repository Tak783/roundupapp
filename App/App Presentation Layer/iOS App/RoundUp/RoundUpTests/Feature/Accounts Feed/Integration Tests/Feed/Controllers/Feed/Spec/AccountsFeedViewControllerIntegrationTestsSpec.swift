//
//  AccountsFeedViewControllerIntegrationTestsSpec.swift
//  RoundUpAppTests
//
//  Created by TM.Dev on 13/04/2021.
//

import XCTest
@testable import RoundUp

typealias AccountsFeedViewControllerIntegrationTest = XCTestCase & AccountsFeedViewControllerIntegrationTestsSpec

protocol AccountsFeedViewControllerIntegrationTestsSpec {
    func test_viewDidLoad_triggersAPICall_whichOnError_showsErrorState()
    func test_viewDidLoad_triggersAPICall_whichOnSuccess_reloadsFeed()
}
