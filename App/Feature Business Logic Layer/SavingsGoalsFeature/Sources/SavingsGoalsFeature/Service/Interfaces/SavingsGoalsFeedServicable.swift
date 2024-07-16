//
//  SavingsGoalsFeedServicable.swift
//  SavingsGoalsFeature
//
//  Created by TM.Dev on 07/06/2021.
//

public protocol SavingsGoalsFeedServicable: AnyObject  {
    typealias SavingsGoalsResult = Swift.Result<[SavingsGoal], Error>

    func loadSavingsGoalsforAccount(
        withUID accountUID: String,
        completion: @escaping (SavingsGoalsResult) -> Void
    )
}
