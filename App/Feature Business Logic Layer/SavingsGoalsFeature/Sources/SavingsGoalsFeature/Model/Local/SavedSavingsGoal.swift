//
//  SavedSavingsGoal.swift
//  SavingsGoalsFeature
//
//  Created by TM.Dev on 09/06/2021.
//

public struct SavedSavingsGoal: Equatable {
    let transferUid: String
    let success: Bool
    
    public init(
        savingsGoalUid: String,
        success: Bool
    ) {
        self.transferUid = savingsGoalUid
        self.success = success
    }
}
