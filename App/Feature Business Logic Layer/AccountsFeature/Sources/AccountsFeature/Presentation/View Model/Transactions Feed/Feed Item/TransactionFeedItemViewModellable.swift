//
//  File.swift
//  AccountsFeature
//
//  Created by TM.Dev on 06/06/2021.
//

public protocol TransactionFeedItemViewModellable: AnyObject {
    var transaction: Transaction { get }
    var id: String { get }
    var reference: String { get }
    var date: String { get }
    var amount: String { get }
}
