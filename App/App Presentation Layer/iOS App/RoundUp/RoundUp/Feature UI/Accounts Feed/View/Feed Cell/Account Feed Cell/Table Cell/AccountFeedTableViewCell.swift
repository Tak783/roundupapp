//
//  AccountFeedTableViewCell.swift
//  
//
//  Created by TM.Dev on 14/04/2021.
//

import UIKit
import AccountsFeature

final class AccountFeedTableViewCell: UITableViewCell {
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var currencyLabel: UILabel!
    @IBOutlet private var createdAtLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupViewForDefaultState()
    }

    private func setupViewForDefaultState() {
        nameLabel.text = "-"
        currencyLabel.text = "-"
        createdAtLabel.text = "-"
    }
}

extension AccountFeedTableViewCell: AccountFeedCell {
    func update(
        with viewModel: AccountFeedItemViewModellable
    ) {
        nameLabel.text = viewModel.name
        currencyLabel.text = "\(Localized.Accounts.currency): \(viewModel.currency)"
        createdAtLabel.text = "\(Localized.Accounts.dateCreated): \(viewModel.createdAt)"
    }
}
