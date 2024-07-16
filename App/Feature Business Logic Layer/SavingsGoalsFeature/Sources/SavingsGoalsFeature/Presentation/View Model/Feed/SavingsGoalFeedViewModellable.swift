//
//  SavingsGoalFeedViewModellable.swift
//  SavingsGoalsFeature
//
//  Created by TM.Dev on 07/06/2021.
//

import CoreFoundational
import Foundation

public protocol SavingsGoalFeedViewModellable: AnyObject {
    var title: String { get }
    var state: SavingsGoalFeedViewModelViewState { get }
    var coordinator: SelectSavingsGoalCoordinatorable? { get }

    var onLoadingStateChange: Observer<Bool>? { get set }
    var onFeedLoadError: Observer<String?>? { get set }
    var onFeedLoadSuccess: Observer<Void>? { get set }

    var savingsGoalsFeedService: SavingsGoalsFeedServicable { get set }
    var feedItemViewModels: [SavingsGoalFeedItemViewModellable] { get }
    
    func loadFeed()
    
    func didRequestToAddRoundUpToSavingsGoal(
        atIndex index: Int
    )
}
