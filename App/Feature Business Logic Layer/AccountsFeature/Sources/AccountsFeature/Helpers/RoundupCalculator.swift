//
//  RoundupCalculator.swift
//  AccountsFeature
//
//  Created by TM.Dev on 10/06/2021.
//

import CoreStarlingEngineSharedModels
import Foundation

public struct RoundupCalculator: RoundupCalculatable {
    public static func calculateRoundUp(
        forTransactions transactions: [Transaction],
        currency: String
    ) -> Amountable {
        var roundUpTotal = 0.00
        transactions.forEach { transaction in
            let amount = transaction.amount.toMajorUnits()
            let roundUp = roundUpAndGetLeftover(amount)
            roundUpTotal += roundUp.rounded(toPlaces: 2)
        }
        let roundUpTotalMinorUnits = Int(roundUpTotal * 100)
        if roundUpTotalMinorUnits > 0 {
            return Amount(
                currency: currency,
                minorUnits: roundUpTotalMinorUnits
            )
        } else {
            return Amount(
                currency: currency,
                minorUnits: 0
            )
        }
    }
    
    public static func transactionDate(
        startingAtDate initialDate: Date,
        daysToAdd: Int = 7
    ) -> Date {
        var dateComponents = DateComponents()
        dateComponents.day = daysToAdd
        guard let maxTransactionDate = Calendar.current.date(
            byAdding: dateComponents,
            to: initialDate
        ) else {
            fatalError(
                "Could not create `maxTransactionDate` from `initialDate`"
            )
        }
        return maxTransactionDate
    }
}

// MARK: - Round up calculator
extension RoundupCalculator {
    private static func roundUpAndGetLeftover(
        _ number: Double
    ) -> Double {
        let roundedNumber = Int(ceil(number))
        let leftover = Double(roundedNumber) - number
        return leftover
    }
}
