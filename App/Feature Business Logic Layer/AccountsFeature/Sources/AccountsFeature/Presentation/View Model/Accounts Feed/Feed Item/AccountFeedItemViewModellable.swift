//
//  AccountFeedItemViewModellable.swift
//  AccountsFeature
//
//  Created by TM.Dev on 15/04/2021.
//

public protocol AccountFeedItemViewModellable: AnyObject {
    var account: Account { get }
    var name: String { get }
    var currency: String { get }
    var createdAt: String { get }
}
