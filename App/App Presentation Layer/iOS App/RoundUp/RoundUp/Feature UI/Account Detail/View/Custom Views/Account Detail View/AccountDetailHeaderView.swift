//
//  AccountDetail.swift
//  
//
//  Created by TM.Dev on 17/04/2021.
//

import CorePresentation
import CoreUIKit
import AccountsFeature
import UIKit

final class AccountDetailHeaderView: NibView {
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var roundUpLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViewForDefaultState()
    }
}

// MARK: - Set Up View
extension AccountDetailHeaderView {
    private func setupViewForDefaultState() {
        nameLabel.text = "-"
        roundUpLabel.text = "-"
    }
}

// MARK: - Update View
extension AccountDetailHeaderView {
    func update(with viewModel: AccountDetailHeaderViewModellable) {
        nameLabel.text = "\(Localized.Accounts.accountName): \(viewModel.name)"
        roundUpLabel.text = "\(Localized.Accounts.weekRoundUpTotal): \(viewModel.weekRoundUpTotal)"
    }
}
