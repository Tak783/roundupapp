//
//  SpySavingsGoalsFeed.swift
//
//
//  Created by TM.Dev on 15/07/2024.
//

import Foundation
import SavingsGoalsFeature

final class SpySavingsGoalsFeed: NSObject {
    var isLoading = false
    var didSuccessfullyLoadFeed = false
    var error: String?

    var viewModel: SavingsGoalFeedViewModel

    init(viewModel: SavingsGoalFeedViewModel) {
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
            self.didSuccessfullyLoadFeed = true
        }
    }
}
