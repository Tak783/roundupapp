//
//  NumberFormatter+Convenience.swift
//
//
//  Created by TM.Dev on 11/07/2024.
//

import Foundation

public extension NumberFormatter {
    convenience init(style: Style, locale: Locale = .current) {
        self.init()
        self.locale = locale
        numberStyle = style
    }
}
