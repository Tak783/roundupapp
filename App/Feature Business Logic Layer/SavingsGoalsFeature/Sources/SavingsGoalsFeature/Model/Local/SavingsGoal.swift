//
//  SavingsGoal.swift
//  SavingsGoalsFeature
//
//  Created by TM.Dev on 07/06/2021.
//

import CoreStarlingEngineSharedModels

public struct SavingsGoal: Equatable {
    public let savingsGoalUid: String
    public let name: String
    public let target: GoalTarget
    public let totalSaved: TotalSaved
    public let savedPercentage: Int
    
    public init(
        savingsGoalUid: String,
        name: String,
        target: GoalTarget,
        totalSaved: TotalSaved,
        savedPercentage: Int
    ) {
        self.savingsGoalUid = savingsGoalUid
        self.name = name
        self.target = target
        self.totalSaved = totalSaved
        self.savedPercentage = savedPercentage
    }
}
