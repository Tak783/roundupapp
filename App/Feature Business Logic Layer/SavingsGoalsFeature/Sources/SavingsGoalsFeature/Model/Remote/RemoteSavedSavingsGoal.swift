//
//  RemoteSaveSavingsGoalResponse.swift
//  SavingsGoalsFeature
//
//  Created by TM.Dev on 09/06/2021.
//

struct RemoteSavedSavingsGoal: Decodable {
    let savingsGoalUid: String
    let success: Bool
}

// MARK: - Convert to production model
extension RemoteSavedSavingsGoal {
    func toModel() -> SavedSavingsGoal {
        SavedSavingsGoal(
            savingsGoalUid: savingsGoalUid,
            success: success
        )
    }
}
