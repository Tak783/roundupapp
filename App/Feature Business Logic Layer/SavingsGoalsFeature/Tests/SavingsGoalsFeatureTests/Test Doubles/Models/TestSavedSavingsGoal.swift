//
//  TestSavedSavingsGoal.swift
//  SavingsGoalsFeatureTests
//
//  Created by Tak M on 09/06/2021.
//

import SavingsGoalsFeature

struct TestSavedSavingsGoal: Decodable {
    let savingsGoalUid: String
    let success: Bool
}

extension TestSavedSavingsGoal {
    func toModel() -> SavedSavingsGoal {
        SavedSavingsGoal(
            savingsGoalUid: savingsGoalUid,
            success: success
        )
    }
}
