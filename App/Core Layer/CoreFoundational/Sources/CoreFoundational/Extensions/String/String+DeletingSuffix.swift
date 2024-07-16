//
//  String+DeletingSuffix.swift
//  
//
//  Created by TM.Dev on 05/11/2023.
//

import Foundation

extension String {
    /// Removes the given String from the end of the string String.
    /// If the text is not present, returns the original String intact.
    ///
    /// - Parameters:
    ///     - suffix: The text to be removed, e.g. "ViewController"
    ///
    /// - Returns:
    ///     - If suffix was found, String with the suffix removed, e.g. "MainViewController" -> "Main"
    ///     - If no suffix was found, the original string intact. e.g. "MainCoordinator" -> "MainCoordinator"
    ///
    public func deletingSuffix(_ suffix: String) -> String {
        guard self.hasSuffix(suffix) else { return self }
        return String(self.dropLast(suffix.count))
    }
}
