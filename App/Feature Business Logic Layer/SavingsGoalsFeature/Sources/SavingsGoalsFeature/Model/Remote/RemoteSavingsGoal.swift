//
//  RemoteSavingsGoal.swift
//  SavingsGoalsFeature
//
//  Created by TM.Dev on 07/06/2021.
//

import Foundation
import CoreStarlingEngineSharedModels

struct RemoteSavingsGoal: Codable {
    let savingsGoalUid: String
    let name: String
    let target: RemoteGoalTarget
    let totalSaved: RemoteTotalSaved
    let savedPercentage: Int
}

// MARK: - Convert to production models Array
extension Array where Element == RemoteSavingsGoal {
    func toModels() -> [SavingsGoal] {
        self.compactMap {
            $0.toModel()
        }
    }
}
