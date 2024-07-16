//
//  AddMoneyToSavingsGoalViewModel.swift
//  SavingsGoalsFeature
//
//  Created by TM.Dev on 10/06/2021.
//

import CoreFoundational

public final class AddMoneyToSavingsGoalViewModel: AddMoneyToSavingsGoalViewModellable {
    public var addMoneyToSavingsGoalsService: AddMoneyToSavingsGoalsServicable
    
    public var onAddRequestLoadingStateChange: Observer<Bool>?
    public var onAddRequestError: Observer<String?>?
    public var onAddRequestSuccess: Observer<Void>?

    public init(service: AddMoneyToSavingsGoalsServicable) {
        self.addMoneyToSavingsGoalsService = service
    }
    
    public func add(
        amount: Double,
        intoSavingsGoalUid savingsGoalUid: String
    ) {
        onAddRequestLoadingStateChange?(true)
        addMoneyToSavingsGoalsService.add(
            amount: amount,
            intoSavingsGoalUid: savingsGoalUid
        ) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                self.onAddRequestSuccess?(())
            case .failure:
                self.onAddRequestError?("Failed to add money to Savings Goal")
            }
            self.onAddRequestLoadingStateChange?(false)
        }
    }
}
