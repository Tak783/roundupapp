//
//  SaveSavingsGoalViewModellable.swift
//  SavingsGoalsFeature
//
//  Created by TM.Dev on 09/06/2021.
//

import CoreFoundational

public protocol SaveSavingsGoalViewModellable: AnyObject {
    var onSaveRequestLoadingStateChange: Observer<Bool>? { get set }
    var onSaveRequestError: Observer<String?>? { get set }
    var onSaveRequestSuccess: Observer<Void>? { get set }
    
    var coordinator: AddNewSavingsGoalCoordinatorable? { get set }
    var saveSavingsGoalService: SaveSavingsGoalServicable { get set }

    func saveSavingsGoal(
        withName name: String,
        target: Double
    )
    
    func didRequestToPresentNewSavingsGoalForm(
        withGoalName goalName: String,
        goalTarget: String,
        completion: @escaping (String, String) -> Void
    )
}
