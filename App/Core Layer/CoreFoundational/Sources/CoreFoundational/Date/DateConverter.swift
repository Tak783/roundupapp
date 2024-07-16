//
//  DateConverter.swift
//  
//
//  Created by TM.Dev on 22/02/2023.
//

import Foundation

public final class DateConverter {
    private let dateFormatter = DateFormatter()
    private static let `default` = DateConverter()
    
    public static func toDate(dateString: String, format: DateFormat) -> Date? {
        let converter = DateConverter.default
        converter.dateFormatter.timeZone = TimeZone.current
        converter.dateFormatter.dateFormat = format.toString()
        
        if format.toString() == DateFormat.dateTime.toString() {
            if let date = converter.dateFormatter.date(from: dateString) {
                return date
            } else {
                converter.dateFormatter.dateFormat = DateFormat.dateTimeTwo.toString()
                if let date = converter.dateFormatter.date(from: dateString) {
                    return date
                }
            }
        }
        guard let date = converter.dateFormatter.date(from: dateString) else {
            return nil
        }
        return date
    }
    
    public static func toString(date: Date, format: DateFormat) -> String {
        let converter = DateConverter.default
        converter.dateFormatter.timeZone = TimeZone.current
        converter.dateFormatter.dateFormat = format.toString()
        return converter.dateFormatter.string(from: date)
    }
}
