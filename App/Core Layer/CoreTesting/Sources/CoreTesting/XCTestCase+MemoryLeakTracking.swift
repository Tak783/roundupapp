//
//  XCTestCase+MemoryLeakTracking.swift
//  CoreTesting
//
//  Created by TM.Dev
//

import XCTest

public extension XCTestCase {
    func trackForMemoryLeaks(
        _ instance: AnyObject,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        guard #available(iOS 13.0, *) else {
            return
        }
        addTeardownBlock { [weak instance] in
            XCTAssertNil(
                instance,
                "Instance should have been deallocated. Potential memory leak.",
                file: file,
                line: line
            )
        }
    }
}
