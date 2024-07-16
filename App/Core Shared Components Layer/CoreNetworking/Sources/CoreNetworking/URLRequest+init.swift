//
//  URLRequest+init.swift
//
//
//  Created by TM.Dev on 11/07/2024.
//

import Foundation

public extension URLRequest {
    init(method: HTTPMethod, url: URL){
        self.init(url: url)
        httpMethod = method.rawValue
    }
}
