//
//  SaveSavingsGoalServicable.swift
//  SavingsGoalsFeature
//
//  Created by TM.Dev on 09/06/2021.
//

public protocol SaveSavingsGoalServicable: AnyObject  {
    typealias SaveSavingsGoalsResult = Swift.Result<SavedSavingsGoal, Error>
    
    func saveSavingsGoalRequestForAccount(
        withUID accountUID: String,
        goalName: String,
        target: GoalTarget,
        completion: @escaping (SaveSavingsGoalsResult) -> Void
    )
}
