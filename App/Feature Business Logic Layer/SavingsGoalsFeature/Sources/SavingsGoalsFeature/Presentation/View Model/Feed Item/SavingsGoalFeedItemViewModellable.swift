//
//  SavingsGoalFeedItemModellable.swift
//  SavingsGoalsFeatureTests
//
//  Created by TM.Dev on 07/06/2021.
//

public protocol SavingsGoalFeedItemViewModellable: AnyObject {
    var id: String { get }
    var name: String { get }
    var target: String { get }
    var totalSaved: String { get }
    var savedPercentage: String { get }
    var savingsGoal: SavingsGoal { get }
}
