//
//  String+DefaultStringExtensions.swift
//  
//
//  Created by TM.Dev on 19/03/2023.
//

import Foundation

extension String {
    public static var empty = String.init()
    public static var dash = "-"
    public static var newLine = "\n"
    public static var comma = ","
    public static var space = " "
    public static var commaAndSpace = ", "
    public static var unknown = "unknown"
    public static var error = "error"
    public static var ok = "Ok"
}

extension String {
    public var stringByRemovingWhitespaces: String {
        replacingOccurrences(of: String.space, with: String.empty)
    }
}

extension String {
    public var containsWhitespace: Bool {
        return(self.rangeOfCharacter(from: .whitespacesAndNewlines) != nil)
    }
}

extension String {
    public var containsSpecialChracters: Bool {
        return stringByRemovingWhitespaces.range(of: ".*[^A-Za-z0-9].*", options: .regularExpression) != nil
    }
}
