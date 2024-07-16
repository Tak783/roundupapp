//
//  SavingsGoalsCoordinatorable.swift
//
//
//  Created by TM.Dev on 12/07/2024.
//

import Foundation

public protocol SavingsGoalsCoordinatorable:
    AnyObject,
    SelectSavingsGoalCoordinatorable,
    AddNewSavingsGoalCoordinatorable
{
    func navigateToSavingsGoalFeed(
        forState state: SavingsGoalFeedViewModelViewState?
    )
}
