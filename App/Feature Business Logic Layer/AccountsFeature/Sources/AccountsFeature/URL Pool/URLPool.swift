//
//  URLPool.swift
//  AccountsFeature
//
//  Created by TM.Dev on 06/06/2021.
//

import CoreFoundational
import CoreNetworking
import Foundation

// MARK: - URL Components
extension URLPool {
    private static let scheme = "https"
    private static let host = "api-sandbox.starlingbank.com"
    private static let path = "/api/v2/"
    
    private enum EndPoints: String {
        case accounts = "accounts"
        case transactionsFeed = "feed/account"
    }
}

// MARK: - Requests
extension URLPool: AccountsAPIURLPoolable {
    static func accountsRequest() -> URLRequest  {
        let endPoint = path + EndPoints.accounts.rawValue
        let url = configureURL(scheme: scheme, host: host, path: endPoint)
        var request = URLRequest.init(method: .get, url: url)
        request.updateBearerToken()
        return request
    }
    
    static func transactionsRequestBetween(
        minTransactionTimestamp: Date,
        maxTransactionTimestamp: Date,
        forAccountUID accountUID: String,
        categoryUID: String
    ) -> URLRequest {
        let minTransactionTimestampString = DateFormatter.jsonDateTimeFormatter.string(
            from: minTransactionTimestamp
        )
        let maxTransactionTimestampString = DateFormatter.jsonDateTimeFormatter.string(
            from: maxTransactionTimestamp
        )
        let endPoint = path + EndPoints.transactionsFeed.rawValue + "/\(accountUID)" + "/category" + "/\(categoryUID)" + "/transactions-between"
        
        let queryParameters: [URLQueryItem] = [
            .init(name: "minTransactionTimestamp", value: minTransactionTimestampString),
            .init(name: "maxTransactionTimestamp", value: maxTransactionTimestampString)
        ]
        let url = configureURL(
            scheme: scheme,
            host: host,
            path: endPoint,
            parameters: queryParameters
        )
        var request = URLRequest.init(
            method: .get,
            url: url
        )
        request.updateBearerToken()
        return request
    }
}
