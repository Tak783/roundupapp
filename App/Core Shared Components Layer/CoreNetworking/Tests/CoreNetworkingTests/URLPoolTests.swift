//
//  URLPoolTests.swift
//  CoreNetworkingTests
//
//  Created by TM.Dev on 10/04/2021.
//

import XCTest
import CoreNetworking

final class URLPoolTests: XCTestCase {
    private static let scheme = "https"
    private static let host = "api.core.com"
    private static let path = "/feed"

    func test_configureURL_configuresURLCorrectly_withoutQueryParameters() {
        let expectedURL = "https://api.core.com/feed"
        let url = URLPool.configureURL(
            scheme: URLPoolTests.scheme,
            host: URLPoolTests.host,
            path: URLPoolTests.path
        )
        XCTAssertEqual(url.absoluteString, expectedURL)
    }

    func test_configureURL_configuresURLCorrectly_withQueryParameters() {
        let expectedURL = "https://api.core.com/feed?item=0"
        let parameters = [
            URLQueryItem(name: "item", value: "0")
        ]
        let url = URLPool.configureURL(
            scheme: URLPoolTests.scheme,
            host: URLPoolTests.host,
            path: URLPoolTests.path,
            parameters: parameters
        )
        XCTAssertEqual(url.absoluteString, expectedURL)
    }
}
