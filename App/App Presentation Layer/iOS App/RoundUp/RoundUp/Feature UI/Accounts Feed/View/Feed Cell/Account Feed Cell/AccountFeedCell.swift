//
//  AccountFeedCell.swift
//  
//
//  Created by TM.Dev on 15/04/2021.
//

import AccountsFeature

protocol AccountFeedCell: AnyObject {
    func update(with viewModel: AccountFeedItemViewModellable)
}
