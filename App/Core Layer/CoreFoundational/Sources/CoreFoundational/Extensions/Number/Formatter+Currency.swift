//
//  Formatter+Currency.swift
//
//
//  Created by TM.Dev on 11/07/2024.
//

import Foundation

public extension Formatter {
    static let currency = NumberFormatter(style: .currency)
    static let currencyUS = NumberFormatter(style: .currency, locale: .us)
    static let currencyUK = NumberFormatter(style: .currency, locale: .uk)
}
