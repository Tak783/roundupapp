//
//  SaveSavingsGoalViewModel.swift
//  SavingsGoalsFeature
//
//  Created by TM.Dev on 09/06/2021.
//

import CoreFoundational

public final class SaveSavingsGoalViewModel: SaveSavingsGoalViewModellable {
    public var saveSavingsGoalService: SaveSavingsGoalServicable
    
    public var onSaveRequestLoadingStateChange: Observer<Bool>?
    public var onSaveRequestError: Observer<String?>?
    public var onSaveRequestSuccess: Observer<Void>?

    public weak var coordinator: AddNewSavingsGoalCoordinatorable?
    
    public private(set) var accountUID: String
    public private(set) var currencyCode: String

    public init(
        with accountUID: String,
        currencyCode: String,
        service: SaveSavingsGoalServicable,
        coordinator: AddNewSavingsGoalCoordinatorable?
    ) {
        self.accountUID = accountUID
        self.currencyCode = currencyCode
        self.saveSavingsGoalService = service
        self.coordinator = coordinator
    }
    
    public func saveSavingsGoal(
        withName name: String,
        target: Double
    ) {
        onSaveRequestLoadingStateChange?(true)
        let target = GoalTarget(
            currency: currencyCode,
            minorUnits: target.minorUnit
        )
        saveSavingsGoalService.saveSavingsGoalRequestForAccount(
            withUID: accountUID,
            goalName: name,
            target: target) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                self.onSaveRequestSuccess?(())
            case .failure:
                self.onSaveRequestError?("Failed to save Savings Goal")
            }
            self.onSaveRequestLoadingStateChange?(false)
        }
    }
    
    public func didRequestToPresentNewSavingsGoalForm(
        withGoalName goalName: String = "",
        goalTarget: String = "",
        completion: @escaping (String, String) -> Void
    ) {
        coordinator?.presentAddNewSavingsGoalForm(
            withGoalName: goalName,
            goalTarget: goalTarget,
            completion: completion
        )
    }
}
