//
//  AccountsServiceTestSpec.swift
//  AccountsFeatureTests
//
//  Created by TM.Dev on 06/06/2021.
//

import XCTest

protocol RemoteAccountsFeedServiceSpec {
    func test_load_onSuccess_returnsAccounts()
    func test_load_onSuccessWithNon200Code_returnsError()
    func test_load_onSuccessWithNonInvalidData_returnsError()
    func test_load_onFailure_returnsError()
}

typealias AccountsFeedServiceTests = XCTestCase & RemoteAccountsFeedServiceSpec
