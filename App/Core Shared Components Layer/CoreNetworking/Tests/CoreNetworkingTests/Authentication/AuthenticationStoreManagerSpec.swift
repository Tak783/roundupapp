//
//  AuthenticationStoreManagerSpec.swift
//  CoreNetworkingTests
//
//  Created by TM.Dev on 05/06/2021.
//

import Foundation
import XCTest

protocol AuthenticationStoreManagerSpec {
    func test_saveStore_savesAuthenticationStoreInStorage()
    func test_retrieveStore_retrievesAuthenticationStoreFromStorage()
    func test_clearStore_clearsAuthenticationStoreFromStorage()
}

typealias AuthenticationStoreManagerTest = XCTestCase & AuthenticationStoreManagerSpec
