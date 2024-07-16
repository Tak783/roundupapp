//
//  SavingsGoalFeedItemModel.swift
//  SavingsGoalsFeatureTests
//
//  Created by TM.Dev on 07/06/2021.
//

public final class SavingsGoalFeedItemViewModel: SavingsGoalFeedItemViewModellable {
    public private(set) var id: String
    public private(set) var name: String
    public private(set) var target: String
    public private(set) var totalSaved: String
    public private(set) var savedPercentage: String
    public private(set) var savingsGoal: SavingsGoal

    public init(with savingsGoal: SavingsGoal) {
        self.savingsGoal = savingsGoal
        
        id = savingsGoal.savingsGoalUid
        name = savingsGoal.name
        target = savingsGoal.target.toMajorUnits().toCurrency(withCode: savingsGoal.target.currency)
        totalSaved = savingsGoal.totalSaved.toMajorUnits().toCurrency(withCode: savingsGoal.totalSaved.currency)
        savedPercentage = String(savingsGoal.savedPercentage) + "%"
    }
}
