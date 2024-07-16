//
//  RemoteSavingsGoalAddedTo.swift
//  SavingsGoalsFeature
//
//  Created by TM.Dev on 11/06/2021.
//

struct RemoteSavingsGoalAddedTo: Decodable {
    let transferUid: String
    let success: Bool
}

// MARK: - Convert to production model
extension RemoteSavingsGoalAddedTo {
    func toModel() -> SavingsGoalAddedTo {
        SavingsGoalAddedTo(
            savingsGoalUid: transferUid,
            success: success
        )
    }
}
