//
//  TransactionTableViewCell.swift
// LiteBankingClientApp
//
//  Created by TM.Dev on 02/05/2021.
//

import UIKit
import AccountsFeature

final class TransactionTableViewCell: UITableViewCell {
    @IBOutlet private var referenceLabel: UILabel!
    @IBOutlet private var amountLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupViewForDefaultState()
    }

    private func setupViewForDefaultState() {
        referenceLabel.text = "-"
        amountLabel.text = "-"
        dateLabel.text = "-"
    }
}

// MARK: - TransactionFeedCell
extension TransactionTableViewCell: TransactionFeedCell {
    func update(with viewModel: TransactionFeedItemViewModellable) {
        referenceLabel.text = "\(viewModel.reference)"
        amountLabel.text = "\(viewModel.amount)"
        dateLabel.text = "\(viewModel.date)"
    }
}
