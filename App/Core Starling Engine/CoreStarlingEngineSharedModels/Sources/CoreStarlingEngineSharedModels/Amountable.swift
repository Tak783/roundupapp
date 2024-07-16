//
//  Amountable.swift
//  
//
//  Created by TM.Dev on 11/07/2024.
//

import Foundation

public protocol Amountable {
    var currency: String { get }
    var minorUnits: Int { get }
 
    func toMajorUnits() -> Double
}

// MARK: - Default implementations
public extension Amountable {
    func toMajorUnits() -> Double {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currencyISOCode
        currencyFormatter.currencyCode = currency.uppercased()
        currencyFormatter.minimumFractionDigits = 2
        currencyFormatter.maximumFractionDigits = 2
        let decimalMajorUnit = Decimal(minorUnits) / pow(10, currencyFormatter.minimumFractionDigits)
        return NSDecimalNumber(decimal: decimalMajorUnit).doubleValue
    }
}

