//
//  File.swift
//  
//
//  Created by TM.Dev on 15/07/2024.
//

import AccountsFeature
import XCTest

final class SpyAccountsFeed: NSObject {
    var isLoading: Bool = false
    var error: String?
    var accounts: [Account]?

    var viewModel: AccountsFeedViewModel

    init(viewModel: AccountsFeedViewModel) {
        self.viewModel = viewModel
        super.init()

        bind()
    }

    func bind() {
        viewModel.onLoadingStateChange = { [weak self] isLoading in
            guard let self = self else { return }
            self.isLoading = isLoading
        }

        viewModel.onFeedLoadError = { [weak self] error in
            guard let self = self else { return }
            self.error = error
        }

        viewModel.onFeedLoadSuccess = { [weak self] accounts in
            guard let self = self else { return }
            self.accounts = accounts
        }
    }
}
