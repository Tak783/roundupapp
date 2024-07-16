//
//  TransactionFeedCell.swift
// LiteBankingClientApp
//
//  Created by TM.Dev on 02/05/2021.
//

import AccountsFeature

protocol TransactionFeedCell: AnyObject {
    func update(with viewModel: TransactionFeedItemViewModellable)
}
