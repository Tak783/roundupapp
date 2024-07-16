//
//  SavingsGoalAPIURLPoolable.swift
//  SavingsGoalsFeature
//
//  Created by TM.Dev on 07/06/2021.
//

import CoreNetworking
import CoreStarlingEngineSharedModels
import Foundation

protocol SavingsAPIURLPoolable {
    static func savingsGoalFeedRequest(
        forAccountUID accountUID: String
    ) -> URLRequest
    
    static func saveSavingsGoalRequest(
        forAccountUID accountUID: String,
        goalName: String,
        target: GoalTarget
    ) throws -> URLRequest
    
    static func add(
        amount: RemoteTotalSaved, 
        forAccountUID accountUID: String,
        intoSavingsGoalUid savingsGoalUid: String,
        transferGoalsUUID: String
    ) throws -> URLRequest
}
