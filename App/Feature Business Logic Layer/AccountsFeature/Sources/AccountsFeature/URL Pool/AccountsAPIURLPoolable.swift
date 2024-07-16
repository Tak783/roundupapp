//
//  AccountsAPIURLPoolable.swift
//  AccountsFeature
//
//  Created by TM.Dev on 06/06/2021.
//

import Foundation

protocol AccountsAPIURLPoolable {
    static func accountsRequest() -> URLRequest
    
    static func transactionsRequestBetween(
        minTransactionTimestamp: Date,
        maxTransactionTimestamp: Date,
        forAccountUID accountUID: String,
        categoryUID: String
    ) -> URLRequest
}
