//
//  HTTPClientSpy.swift
//  MockNetworking
//
//  Created by TM.Dev on 10/04/2021.
//

import Foundation
import CoreNetworking

public final class HTTPClientSpy: HTTPClient {
    private var messages = [(request: URLRequest, completion: (HTTPClient.Result) -> Void)]()

    public var requests: [URLRequest] {
        return messages.map { $0.request }
    }

    public enum StatusCode: Int {
        case success = 200
        case error = 400
    }

    public init() {}

    public func performRequest(_ request: URLRequest, completion: @escaping (HTTPClient.Result) -> Void) {
        messages.append((request, completion))
    }
}

// **Completion Methods**
// These are the Key method, it is called manually i.e. client.complete(withStatusCode: 200, data: invalidJSON)
// We manually pass in the error
// What happens is that this method changes the completion("the result") part of the struct at index of `messages`
// Once the completion is set, the completion block (a closure) us ran and returns the error
// This mimics the functionality of a HTTP client request
extension HTTPClientSpy {
    public func complete(with error: Error, at index: Int = 0) {
        // What's happening here is, we are now saying completion at index 0 return this errror
        // This then returns the escaped closure
        messages[index].completion(.failure(error))
    }

    public func complete(withStatusCode code: Int = StatusCode.success.rawValue, data: Data, at index: Int = 0) {
        guard let url = requests[index].url else {
            assertionFailure("Request at index must not be nil, and must have a URL ")
            return
        }
        let response = HTTPURLResponse(
            url: url,
            statusCode: code,
            httpVersion: nil,
            headerFields: nil
        )!
        messages[index].completion(.success((data, response)))
    }
}
