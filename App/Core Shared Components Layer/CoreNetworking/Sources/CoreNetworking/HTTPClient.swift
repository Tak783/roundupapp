//
//  HTTPClient.swift
//  CoreNetworking
//
//  Created by TM.Dev on 10/04/2021.
//
//  Client contains a .shared URLSession. We `URLSessionDataTask`s to get, post, put etc data from a server
//

import Foundation

public protocol HTTPClient {
    typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>

    func performRequest(
        _ request: URLRequest, 
        completion: @escaping (Result) -> Void
    )
}
