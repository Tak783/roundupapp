//
//  AddMoneyToSavingsGoalsServicable.swift
//  SavingsGoalsFeature
//
//  Created by TM.Dev on 09/06/2021.
//

import CoreStarlingEngineSharedModels

public protocol AddMoneyToSavingsGoalsServicable: AnyObject  {
    typealias AddMoneyToSavingsResult = Swift.Result<SavingsGoalAddedTo, Error>
    
    func add(
        amount: Double,
        intoSavingsGoalUid savingsGoalUid: String,
        completion: @escaping (AddMoneyToSavingsResult) -> Void
    )
}
