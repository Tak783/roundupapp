//
//  SpySavingsGoalsCoordinator.swift
//  RoundUpTests
//
//  Created by TM.Dev on 15/07/2024.
//

import AccountsFeature
import SavingsGoalsFeature
import CorePresentation
@testable import RoundUp
import UIKit

final class SpySavingsGoalsCoordinator: SavingsGoalsCoordinatorable {
    var didPresentAddNewSavingsGoalForm = false
    var didNavigateToSavingsGoalFeed = false
    var didSelectSavingsGoal = false
    
    func navigateToSavingsGoalFeed(forState state: SavingsGoalsFeature.SavingsGoalFeedViewModelViewState?) {
        didNavigateToSavingsGoalFeed = true
    }
    
    func didSelectSavingsGoal(_ savingsGoal: SavingsGoalsFeature.SavingsGoal) {
        didSelectSavingsGoal = true
    }
    
    func presentAddNewSavingsGoalForm(
        withGoalName goalName: String,
        goalTarget: String,
        completion: @escaping (String, String) -> Void)
    {
        didPresentAddNewSavingsGoalForm = true
    }
}
