//
//  AddMoneyToSavingsGoalViewModellable.swift
//  SavingsGoalsFeature
//
//  Created by TM.Dev on 10/06/2021.
//

import CoreFoundational

public protocol AddMoneyToSavingsGoalViewModellable: AnyObject {
    var onAddRequestLoadingStateChange: Observer<Bool>? { get set }
    var onAddRequestError: Observer<String?>? { get set }
    var onAddRequestSuccess: Observer<Void>? { get set }

    var addMoneyToSavingsGoalsService: AddMoneyToSavingsGoalsServicable { get set }

    func add(
        amount: Double,
        intoSavingsGoalUid savingsGoalUid: String
    )
}
