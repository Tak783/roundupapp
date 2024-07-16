//
//  SavingsGoalTableViewCell.swift
//  RoundUpApp
//
//  Created by TM.Dev on 07/06/2021.
//

import UIKit
import SavingsGoalsFeature

final class SavingsGoalTableViewCell: UITableViewCell {
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var targetLabel: UILabel!
    @IBOutlet private var totalSavedLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupViewForDefaultState()
    }

    private func setupViewForDefaultState() {
        nameLabel.text = "-"
        targetLabel.text = "-"
        totalSavedLabel.text = "-"
    }
}

extension SavingsGoalTableViewCell: SavingsFeedCell {
    func update(with viewModel: SavingsGoalFeedItemViewModellable) {
        nameLabel.text = viewModel.name
        targetLabel.text = "\(Localized.SavingsGoals.target): \(viewModel.target)"
        totalSavedLabel.text = "\(Localized.SavingsGoals.saved): \(viewModel.totalSaved)"
    }
}
