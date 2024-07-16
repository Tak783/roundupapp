//
//  SavingsGoalFeedViewModel.swift
//  SavingsGoalsFeature
//
//  Created by TM.Dev on 07/06/2021.
//

import CoreFoundational
import Foundation

public final class SavingsGoalFeedViewModel {
    public var title: String
    public var state: SavingsGoalFeedViewModelViewState
    
    public var savingsGoalsFeedService: SavingsGoalsFeedServicable
    
    public var onLoadingStateChange: Observer<Bool>?
    public var onFeedLoadError: Observer<String?>?
    public var onFeedLoadSuccess: Observer<Void>?
   
    public weak var coordinator: SelectSavingsGoalCoordinatorable?
    
    public private(set) var accountUID: String
    public private(set) var savingsGoals = [SavingsGoal]()
    public private(set) var feedItemViewModels = [SavingsGoalFeedItemViewModellable]()
    
    public init(
        with accountUID: String,
        service: SavingsGoalsFeedServicable,
        title: String,
        state: SavingsGoalFeedViewModelViewState = .normal,
        coordinator: SelectSavingsGoalCoordinatorable?
    ) {
        self.accountUID = accountUID
        self.savingsGoalsFeedService = service
        self.title = title
        self.state = state
        self.coordinator = coordinator
    }
}
    
// MARK: - SavingsGoalFeedViewModellable
extension SavingsGoalFeedViewModel: SavingsGoalFeedViewModellable {
    public func loadFeed() {
        onLoadingStateChange?(true)
        savingsGoalsFeedService.loadSavingsGoalsforAccount(
            withUID: accountUID
        )  { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let savingsGoals):
                self.didLoadSavingsGoals(
                    withSavingsGoals: savingsGoals
                )
                self.onFeedLoadSuccess?(())
            case .failure:
                self.onFeedLoadError?("Failed to load feed")
            }
            self.onLoadingStateChange?(false)
        }
    }
    
    private func didRequestToPresentNewSavingsGoalForm(
        withGoalName goalName: String = "",
        goalTarget: String = "",
        completion: @escaping (String, String) -> Void
    ) {
        guard let coordinator = coordinator as? AddNewSavingsGoalCoordinatorable else {
            assertionFailure("Expected `coordinator` conform to `SavingsGoalsCoordinatorable`")
            return
        }
        coordinator.presentAddNewSavingsGoalForm(
            withGoalName: goalName,
            goalTarget: goalTarget,
            completion: completion
        )
    }
    
    public func didRequestToAddRoundUpToSavingsGoal(
        atIndex index: Int
    ) {
        guard savingsGoals.indices.contains(index) else {
            return
        }
        let savingsGoal = savingsGoals[index]
        coordinator?.didSelectSavingsGoal(savingsGoal)
    }
}

// MARK: - Feed Load Helpers
extension SavingsGoalFeedViewModel {
    private func didLoadSavingsGoals(
        withSavingsGoals newSavingsGoals: [SavingsGoal]
    ) {
        savingsGoals = newSavingsGoals
        feedItemViewModels = savingsGoals.map({ savingsGoal in
            SavingsGoalFeedItemViewModel(with: savingsGoal)
        })
    }
}
