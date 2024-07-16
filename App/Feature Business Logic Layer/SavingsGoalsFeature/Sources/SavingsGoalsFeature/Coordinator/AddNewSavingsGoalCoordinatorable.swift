//
//  AddNewSavingsGoalCoordinatorable.swift
//
//
//  Created by TM.Dev on 12/07/2024.
//

import Foundation

public protocol AddNewSavingsGoalCoordinatorable: AnyObject {
    func presentAddNewSavingsGoalForm(
        withGoalName goalName: String,
        goalTarget: String,
        completion:  @escaping (String, String) -> Void
    )
}
