//
//  TestSavingsGoal.swift
//  SavingsGoalsFeatureTests
//
//  Created by TM.Dev on 07/06/2021.
//

import Foundation
import CoreStarlingEngineSharedModels
import SavingsGoalsFeature

struct TestSavingsGoal: Codable {
    let savingsGoalUid: String
    let name: String
    let target: TestGoalTarget
    let totalSaved: TestTotalSaved
    let savedPercentage: Int
}

struct TestGoalTarget: Codable, Amountable {
    var currency: String
    var minorUnits: Int
}

struct TestTotalSaved: Codable, Amountable {
    var currency: String
    var minorUnits: Int
}

extension TestSavingsGoal {
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

extension Array where Element == TestSavingsGoal {
    func toModels() -> [SavingsGoal] {
        self.compactMap {
            $0.toModel()
        }
    }
}
