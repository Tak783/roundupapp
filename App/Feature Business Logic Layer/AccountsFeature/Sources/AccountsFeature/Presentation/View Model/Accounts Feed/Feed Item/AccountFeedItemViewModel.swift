//
//  AccountFeedItemViewModel.swift
//  AccountsFeature
//
//  Created by TM.Dev on 15/04/2021.
//

import CoreFoundational
import Foundation

public final class AccountFeedItemViewModel: AccountFeedItemViewModellable {
    public private(set) var account: Account
    public private(set) var name: String
    public private(set) var currency: String
    public private(set) var createdAt: String

    public init(
        with account: Account
    ) {
        self.account = account
        name = account.name
        currency = account.currency
        createdAt = DateFormatter.shortStyleDateTimeFormatter.string(
            from: account.createdAt
        )
    }
}
