//
//  SavingsGoalFeedViewController+DSLHelpers.swift
//  RoundUpAppTests
//
//  Created by TM.Dev on 08/06/2021.
//

import UIKit
import CoreUIKit
@testable import RoundUp

// MARK: - Domain Specific Language Var's
extension SavingsGoalFeedViewController {
    var table: UITableView? {
        view.findChildView(byAccessibilityIdentifier: "savings-goals-feed-table") as? UITableView
    }
    
    var loadingIndicator: UIRefreshControl? {
        table?.refreshControl
    }
    
    var addNewSavingsGoalButton: UIBarButtonItem? {
        navigationItem.rightBarButtonItem
    }

    var isShowingLoadingState: Bool {
        guard let loadingView = loadingIndicator else {
            assertionFailure("Loading Indicator should be present")
            return false
        }
        return loadingView.isRefreshing
    }

    var errorView: UIView? {
        view.findChildView(byAccessibilityIdentifier: "error-view")
    }

    var isShowingErrorState: Bool {
        if errorView == nil {
            assertionFailure("Error View should not be nil")
        }
        if errorView?.isHidden == false, isShowingLoadingState == false  {
            return true
        }
        return false
    }
}
