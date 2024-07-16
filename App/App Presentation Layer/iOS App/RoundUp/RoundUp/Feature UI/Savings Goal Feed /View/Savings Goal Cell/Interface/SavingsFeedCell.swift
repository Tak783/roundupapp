//
//  SavingsFeedCell.swift
//  RoundUpApp
//
//  Created by TM.Dev on 07/06/2021.
//

import SavingsGoalsFeature

protocol SavingsFeedCell: AnyObject {
    func update(
        with viewModel: SavingsGoalFeedItemViewModellable
    )
}
