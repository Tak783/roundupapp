//
//  SavingsGoalsFeedComposer.swift
//  RoundUpApp
//
//  Created by TM.Dev on 08/06/2021.
//

import CoreFoundational
import SavingsGoalsFeature
import CorePresentation
import CoreUIKit
import UIKit

final class SavingsGoalsFeedComposer {
    static func compose(
        forAccountUid uid: String,
        currencyCode: String,
        feedService: SavingsGoalsFeedServicable,
        saveSavingsGoalService: SaveSavingsGoalServicable,
        feedState: SavingsGoalFeedViewModelViewState = .normal,
        title: String,
        coordinator: SavingsGoalsCoordinatorable
    ) -> SavingsGoalFeedViewController {
        let feedViewModel = SavingsGoalFeedViewModel(
            with: uid,
            service: feedService,
            title: title,
            state: feedState,
            coordinator: coordinator
        )
        let saveSavingsGoalViewModel = SaveSavingsGoalViewModel(
            with: uid,
            currencyCode: currencyCode,
            service: saveSavingsGoalService,
            coordinator: coordinator
        )
        let savingsGoalsFeedViewController = make(
            with: feedViewModel,
            saveSavingsGoalViewModel: saveSavingsGoalViewModel
        )
        return savingsGoalsFeedViewController
    }
}

// MARK: - Create SavingsGoalsFeedViewController
extension SavingsGoalsFeedComposer {
    private static func make(
        with feedViewModel: SavingsGoalFeedViewModellable,
        saveSavingsGoalViewModel: SaveSavingsGoalViewModellable
    ) -> SavingsGoalFeedViewController {
        let savingsGoalsFeedViewController = SavingsGoalFeedViewController.instantiate()
        savingsGoalsFeedViewController.feedViewModel = feedViewModel
        savingsGoalsFeedViewController.saveSavingsGoalViewModel = saveSavingsGoalViewModel
        return savingsGoalsFeedViewController
    }
}
