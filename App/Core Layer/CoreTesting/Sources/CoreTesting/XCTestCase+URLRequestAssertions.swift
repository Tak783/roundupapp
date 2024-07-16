//
//  XCTestCase+Assertions.swift
//  CoreTesting
//
//  Created by TM.Dev on 10/04/2021.
//

import Foundation
import XCTest

extension XCTestCase {
    public func assert(
        request: URLRequest?,
        urlAbsoluteString: String,
        httpMethod: URLRequest.HTTPMethod,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        guard let request = request else {
            XCTFail("Expected request to not be nil", file: file, line: line)
            return
        }
        XCTAssertEqual(
            request.httpMethod,
            httpMethod.rawValue,
            file: file, 
            line: line
        )
        XCTAssertEqual(
            request.url?.absoluteString,
            urlAbsoluteString,
            file: file,
            line: line
        )
    }
    
    public func assert(
        request: URLRequest,
        hasExpectedBearerToken token: String,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        XCTAssertEqual(
            request.value(forHTTPHeaderField: "Authorization"), "Bearer \(token)",
            file: file,
            line: line
        )
    }
    
    public func assert(
        request: URLRequest,
        hasExpectedContentType contentType: URLRequest.ContentType,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        XCTAssertEqual(
            request.value(forHTTPHeaderField: "Content-Type"), 
            contentType.rawValue,
            file: file,
            line: line
        )
    }
}

public extension URLRequest {
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
    }
    
    enum ContentType: String {
        case json = "application/json"
        case formURLencoded = "application/x-www-form-urlencoded"
    }
}
