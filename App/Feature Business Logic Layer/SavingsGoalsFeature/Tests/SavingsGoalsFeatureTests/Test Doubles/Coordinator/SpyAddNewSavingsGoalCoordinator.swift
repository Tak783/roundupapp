//
//  SpyAddNewSavingsGoalCoordinator.swift
//
//
//  Created by TM.Dev on 15/07/2024.
//

import Foundation
import SavingsGoalsFeature

final class SpyAddNewSavingsGoalCoordinator: AddNewSavingsGoalCoordinatorable {
    var didPresentAddNewSavingsGoalForm = false
    
    func presentAddNewSavingsGoalForm(
        withGoalName goalName: String,
        goalTarget: String,
        completion: @escaping (String, String) -> Void)
    {
        didPresentAddNewSavingsGoalForm = true
    }
}
