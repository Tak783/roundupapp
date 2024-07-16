//
//  DateFormatter+Extensions.swift
//  
//
//  Created by TM.Dev on 18/03/2023.
//

import Foundation

// MARK: - Static formatters
extension DateFormatter {
    /// Returns a short style date/time formatter in user's locale.  E.g., 07/11/2016, 16:37
    public static let shortStyleDateTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_GB")
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    public static let jsonDateTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        // From https://nsdateformatter.com : Best Practices Page
        // Always use the en_US_POSIX locale for fixed formats
        // If you don't force the locale to en_US_POSIX, there are risks that your code
        // might seem to work in some regions (like the US), but will fail to parse your API
        // responses if the user has its phone set in another region (e.g. en_GB, en_ES or fr_FR),
        // where date formatting is different, or use 12-hour time and not 24-hour time.
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return formatter
    }()
}
