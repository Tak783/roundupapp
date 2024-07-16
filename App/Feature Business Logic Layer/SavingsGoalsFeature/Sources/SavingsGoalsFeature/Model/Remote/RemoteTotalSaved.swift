//
//  RemoteTotalSaved.swift
//  SavingsGoalsFeature
//
//  Created by TM.Dev on 10/07/2024.
//

import Foundation
import CoreStarlingEngineSharedModels

struct RemoteTotalSaved: Codable, Amountable {
    var currency: String
    var minorUnits: Int
}
// MARK: - Convert to production model
extension RemoteSavingsGoal {
    func toModel() -> SavingsGoal {
        SavingsGoal(
            savingsGoalUid: savingsGoalUid,
            name: name,
            target: GoalTarget(
                currency: target.currency,
                minorUnits: target.minorUnits
            ),
            totalSaved: TotalSaved(
                currency: totalSaved.currency,
                minorUnits: totalSaved.minorUnits
            ),
            savedPercentage: savedPercentage
        )
    }
}
