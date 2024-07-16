//
//  Localized+Savings.swift
//  
//
//  Created by TM.Dev on 07/06/2021.
//

import Foundation

extension Localized {
    enum SavingsGoals {
        static var table: String { "SavingsGoals" }

        static var feed: String {
            NSLocalizedString(
                "savings-goals-feed",
                tableName: table,
                bundle: bundle,
                comment: "Title for Savings Goals `Feed`"
            )
        }
        
        static var savingsGoalsFeedSelect: String {
            NSLocalizedString(
                "savings-goals-feed-select",
                tableName: table,
                bundle: bundle,
                comment: "Title for Savings Goals `Feed` when selecting savings goal to save the round up into"
            )
        }

        static var target: String {
            NSLocalizedString(
                "target",
                tableName: table,
                bundle: bundle,
                comment: "Title for Savings Goals `Target`"
            )
        }
        
        static var saved: String {
            NSLocalizedString(
                "saved",
                tableName: table,
                bundle: bundle,
                comment: "Title for Savings Goals `Total Saved`"
            )
        }
        
        static var savedPercentage: String {
            NSLocalizedString(
                "savedPercentage",
                tableName: table,
                bundle: bundle,
                comment: "Title for Savings Goals `Saved Percenatage`"
            )
        }
    }
}
