//
//  XCTestCase+UserDefaults.swift
//  CoreTesting
//
//  Created by TM.Dev on 06/06/2021.
//

import Foundation
import XCTest

public extension XCTestCase {
    static func resetUserDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
}

