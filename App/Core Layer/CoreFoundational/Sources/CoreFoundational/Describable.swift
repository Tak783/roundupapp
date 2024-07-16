//
//  Describable.swift
//
//
//  Created by TM.Dev on 17/10/2023.
//

import Foundation

public protocol Describable {
    static func objectName() -> String
}

// MARK: - Default implementation
extension Describable {
    public static func objectName() -> String {
        return String(describing: Self.self)
    }
}
