//
//  SelectSavingsGoalCoordinatorable.swift
//
//
//  Created by TM.Dev on 12/07/2024.
//

import Foundation

public protocol SelectSavingsGoalCoordinatorable: AnyObject {
    func didSelectSavingsGoal(_ savingsGoal: SavingsGoal)
}
