//
//  Localized+Accounts.swift
//  
//
//  Created by TM.Dev on 07/06/2021.
//

import Foundation

extension Localized {
    enum Accounts {
        static var table: String { "Accounts" }

        static var feed: String {
            NSLocalizedString(
                "accounts-feed",
                tableName: table,
                bundle: bundle,
                comment: "Title for `Accounts Feed`"
            )
        }

        static var accountName: String {
            NSLocalizedString(
                "account-name",
                tableName: table,
                bundle: bundle,
                comment: "Title for `Account name`"
            )
        }
        
        static var bankName: String {
            NSLocalizedString(
                "bank-name",
                tableName: table,
                bundle: bundle,
                comment: "Title for `Bank name`"
            )
        }

        static var balance: String {
            NSLocalizedString(
                "balance",
                tableName: table,
                bundle: bundle,
                comment: "Title for `Bank Balance`"
            )
        }
        
        static var currency: String {
            NSLocalizedString(
                "currency",
                tableName: table,
                bundle: bundle,
                comment: "Title for `Bank Currency`"
            )
        }

        static var accountNumber: String {
            NSLocalizedString(
                "account-number",
                tableName: table,
                bundle: bundle,
                comment: "Title for `Account Number`"
            )
        }

        static var sortCode: String {
            NSLocalizedString(
                "sort-code",
                tableName: table,
                bundle: bundle,
                comment: "Title for `Sort Code`"
            )
        }

        static var dateCreated: String {
            NSLocalizedString(
                "date-created",
                tableName: table,
                bundle: bundle,
                comment: "Title for `Date Added`"
            )
        }
        
        
        static var detail: String {
            NSLocalizedString(
                "account-detail",
                tableName: table,
                bundle: bundle,
                comment: "Title for `Account Detail`"
            )
        }
        
        static var weekRoundUpTotal: String {
            NSLocalizedString(
                "week-round-up-total",
                tableName: table,
                bundle: bundle,
                comment: "Title for `Week Round Up Total`"
            )
        }
    }
}
