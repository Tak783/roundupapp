//
//  SavingsGoalsCoordinator.swift
//  RoundUp
//
//  Created by TM.Dev on 12/07/2024.
//

import AccountsFeature
import CoreFoundational
import CoreNetworking
import CorePresentation
import CoreUIKit
import Foundation
import SavingsGoalsFeature
import UIKit

final class SavingsGoalsCoordinator: ChildCoordinatorable {
    let client: HTTPClient
    var router: Router
    var parentCoordinator: ParentCoordinatorable?
    let account: Account
    
    init(
        router: Router,
        account: Account,
        client: HTTPClient,
        parentCoordinator: ParentCoordinatorable?
    ) {
        self.router = router
        self.account = account
        self.client = client
        self.parentCoordinator = parentCoordinator
    }

    func start() {
        navigateToSavingsGoalFeed(forState: .normal)
    }
}

// MARK: - SavingsGoalsCoordinatorable
extension SavingsGoalsCoordinator: SavingsGoalsCoordinatorable {
    func navigateToSavingsGoalFeed(forState state: SavingsGoalFeedViewModelViewState?) {
        let savingsGoalsFeedService = RemoteSavingsGoalsFeedService(client: client)
        let saveSavingsGoalsFeedService = RemoteSaveSavingsGoalService(client: client)
        
        let savingsGoalFeedViewController = SavingsGoalsFeedComposer.compose(
            forAccountUid: account.accountUid,
            currencyCode: account.currency,
            feedService: savingsGoalsFeedService,
            saveSavingsGoalService: saveSavingsGoalsFeedService,
            feedState: state ?? .normal,
            title: state == .normal ? Localized.SavingsGoals.feed : Localized.SavingsGoals.savingsGoalsFeedSelect,
            coordinator: self
        )
        router.navigateToViewController(savingsGoalFeedViewController, withMethod: .push)
    }
}

// MARK: - SelectSavingsGoalCoordinatorable
extension SavingsGoalsCoordinator: SelectSavingsGoalCoordinatorable {
    func didSelectSavingsGoal(_ savingsGoal: SavingsGoal) {
        guard
            let viewController = parentCoordinator?.router.navigationController.topViewController as? AccountDetailViewController else {
            return
        }
        viewController.didSelectSavingGoalToAddRoundUpTotal(savingsGoal: savingsGoal)
        end()
    }
}

// MARK: - AddNewSavingsGoalCoordinatorable
extension SavingsGoalsCoordinator: AddNewSavingsGoalCoordinatorable {
    // P1-0003: Did not write tests for this, for it is such an MVP feature
    func presentAddNewSavingsGoalForm(
        withGoalName goalName: String,
        goalTarget: String,
        completion: @escaping (String, String) -> Void
    ) {
        let alert = UIAlertController(
            title: "Create Savings Goals",
            message: "Add Goal Name and Target",
            preferredStyle: .alert
        )

        alert.addTextField { (textField) in
            textField.text = goalName
            textField.placeholder = "Goal Name"
            textField.keyboardType = .namePhonePad
        }
        
        alert.addTextField { (textField) in
            textField.text = goalTarget
            textField.placeholder = "Target"
            textField.keyboardType = .numberPad
        }

        alert.addAction(
            UIAlertAction(title: "Submit", style: .default, handler: { [weak alert] (_) in
            let goalNameEntry = alert?.textFields![0].text ?? ""
            let goalTargetEntry = alert?.textFields![1].text ?? ""
            completion(goalNameEntry, goalTargetEntry)
        }))
        
        alert.addAction(
            UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        )

        router.navigateToViewController(alert, withMethod: .present, animated: true)
    }
}
