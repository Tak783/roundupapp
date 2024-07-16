//
//  Double+Extensions.swift
//  Core
//
//  Created by TM.Dev on 10/06/2021.
//

import Foundation

public extension Double {
    var currency: String {
        Formatter.currencyUK.string(for: self) ?? self.toCurrency()
    }
    
    var currencyUnkown: String {
        self.toCurrency(withSymbol: .empty)
    }
    
    var currencyUS: String {
        Formatter.currencyUS.string(for: self) ?? self.toCurrency(withSymbol: "$")
    }
    
    var currencyEUR: String {
        self.toCurrency(withSymbol: "€")
    }
    
    var currencyUK: String {
        Formatter.currencyUK.string(for: self) ?? self.toCurrency(withSymbol: "£")
    }
}

// MARK: - Currency
public extension Double {
    private func toCurrency(withSymbol symbol: String = .empty) -> String {
        return String(format: "%@%0.2f", symbol, self)
    }
    
    func toCurrency(withCode code: String) -> String {
        switch code.lowercased() {
        case "gbp":
            return currencyUK
        case "usd":
            return currencyUS
        case "eur":
            return currencyUnkown
        default:
            return currencyUnkown
        }
    }
}

public extension Double {
    var minorUnit: Int {
        Int(self * 100)
    }
}

extension Double {
    // TODO: for `toCurrency(withCode`
    // - Use the below when you have figured out how to get rid of the space between the symbol and number `"£ 1,000.00"`
    //
    // let localeIdentifier = Locale.identifier(fromComponents: [NSLocale.Key.currencyCode.rawValue : code])
    // let locale = Locale(identifier: code)
    // let formatter = NumberFormatter(style: .currency, locale: locale)
}
