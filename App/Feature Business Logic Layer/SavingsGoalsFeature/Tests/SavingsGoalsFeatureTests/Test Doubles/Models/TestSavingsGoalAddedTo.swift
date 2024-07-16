//
//  TestSavingsGoalAddedTo.swift
//  SavingsGoalsFeatureTests
//
//  Created by Tak M on 11/06/2021.
//

import SavingsGoalsFeature

struct TestSavingsGoalAddedTo: Decodable {
    let transferUid: String
    let success: Bool
}

extension TestSavingsGoalAddedTo {
    func toModel() -> SavingsGoalAddedTo {
        SavingsGoalAddedTo(
            savingsGoalUid: transferUid,
            success: success
        )
    }
}
