//
//  URLRequest+HTTPMethod.swift
//
//
//  Created by TM.Dev on 11/07/2024.
//

import Foundation

public extension URLRequest {
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
    }
}
