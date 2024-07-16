//
//  Date+Add.swift
//  
//
//

import Foundation

extension Date {
    public func day(using calendar: Calendar = .current) -> Int {
        calendar.component(.day, from: self)
    }
    
    public func adding(_ component: Calendar.Component, value: Int, using calendar: Calendar = .current) -> Date {
        calendar.date(byAdding: component, value: value, to: self)!
    }
    
    public func monthSymbol(using calendar: Calendar = .current) -> String {
        calendar.monthSymbols[calendar.component(.month, from: self)-1]
    }
    
    public func twoYearsAgo() -> Date {
        let dateTwoYearsAgo = Calendar.current.date(
            byAdding: .year,
            value: -2,
            to: self
        )!
        return dateTwoYearsAgo
    }
}
