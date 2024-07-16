//
//  SpyTransactionsFeed.swift
//
//
//  Created by TM.Dev on 15/07/2024.
//

import AccountsFeature
import XCTest

final class SpyTransactionsFeed: NSObject {
    var isLoading = false
    var didSuccessfulyLoadTransactions: Bool = false
    var error: String?

    var viewModel: TransactionsFeedViewModel

    init(viewModel: TransactionsFeedViewModel) {
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

        viewModel.onFeedLoadSuccess = { [weak self] _ in
            guard let self = self else { return }
            self.didSuccessfulyLoadTransactions = true
        }
    }
}
