//
//  SpySelectSavingsGoalCoordinatorable.swift
//
//
//  Created by TM.Dev on 15/07/2024.
//

import XCTest
import SavingsGoalsFeature

final class SpySelectSavingsGoalCoordinator: SelectSavingsGoalCoordinatorable {
    var savingsGoalSelected = false
    
    func didSelectSavingsGoal(_ savingsGoal: SavingsGoalsFeature.SavingsGoal) {
        savingsGoalSelected = true
    }
}
