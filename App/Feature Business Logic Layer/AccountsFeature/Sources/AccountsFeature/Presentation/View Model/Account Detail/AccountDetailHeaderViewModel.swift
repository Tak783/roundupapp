//
//  AccountDetailHeaderViewModel.swift
//  AccountsFeature
//
//  Created by TM.Dev on 06/06/2021.
//

import CoreStarlingEngineSharedModels
import Foundation

public final class AccountDetailHeaderViewModel: AccountDetailHeaderViewModellable {
    public var id: String
    public var name: String
    public var createdAt: String
    public var weekRoundUpTotal: String
    public var weekRoundUp: Amountable
    
    public init(
        with account: Account,
        minimumTransactionDate: Date,
        weeksRoundUpTotal: Amountable
    ) {
        weekRoundUp = weeksRoundUpTotal
        
        id = account.accountUid
        name = account.name
        createdAt = DateFormatter.shortStyleDateTimeFormatter.string(
            from: account.createdAt
        )
        weekRoundUpTotal = weeksRoundUpTotal.toMajorUnits().toCurrency(
            withCode: weeksRoundUpTotal.currency
        )
    }
    
    public func update(
        withWeekRoundUpTotal updatedWeekRoundUpTotal: Amountable
    ) {
        weekRoundUp = updatedWeekRoundUpTotal
        weekRoundUpTotal = updatedWeekRoundUpTotal.toMajorUnits().toCurrency(
            withCode: updatedWeekRoundUpTotal.currency
        )
    }
}

