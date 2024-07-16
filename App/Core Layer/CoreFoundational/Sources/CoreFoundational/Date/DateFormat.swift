//
//  DateFormat+Extensions.swift
//  
//
//  Created by TM.Dev on 22/02/2023.
//

import Foundation

public enum DateFormat {
    case dateTime
    case dateTimeTwo
    
    public func toString() -> String {
        switch self {
        case .dateTime:
            return "yyyy-MM-dd'T'HH:mm:ssZ"
        case .dateTimeTwo:
            return "yyyy-MM-dd'T'HH:mm:ss"
        }
    }
}
