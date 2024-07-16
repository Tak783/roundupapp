//
//  XCTestCase+WaitForMainThread.swift
//  CoreTesting
//
//  Created by TM.Dev on 04/05/2021.
//

import Foundation
import XCTest

public extension XCTestCase {
    func waitForMainThread() {
        let exp = expectation(description: "wait for main thread")
        DispatchQueue.main.async {
            exp.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
}
