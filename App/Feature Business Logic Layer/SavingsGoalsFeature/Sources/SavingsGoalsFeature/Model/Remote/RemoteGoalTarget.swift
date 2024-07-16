//
//  RemoteGoalTarget.swift
//  SavingsGoalsFeature
//
//  Created by TM.Dev on 10/07/2024.
//

import Foundation
import CoreStarlingEngineSharedModels

struct RemoteGoalTarget: Codable, Amountable {
    var currency: String
    var minorUnits: Int
}
