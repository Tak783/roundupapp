//
//  AccountsSavingsCoordinatorable.swift
//  
//
//  Created by TM.Dev on 10/06/2021.
//

public protocol AccountsSavingsCoordinatorable: AnyObject {
    func didAddToSavingsGoal()
    func navigateToSavingsGoalFeed(withAccount account: Account)
    func navigateToSelectSavingsGoal(for account: Account)
}
