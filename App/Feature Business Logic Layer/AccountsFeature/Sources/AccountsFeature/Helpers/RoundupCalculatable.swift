//
//  RoundupCalculatable.swift
//  AccountsFeature
//
//  Created by TM.Dev on 10/06/2021.
//

import CoreStarlingEngineSharedModels

protocol RoundupCalculatable {
    static func calculateRoundUp(
        forTransactions transactions: [Transaction],
        currency: String
    ) -> Amountable
}
