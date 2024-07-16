//
//  AccountsFeedViewController+DSLHelpers.swift
//  RoundUpAppTests
//
//  Created by TM.Dev on 12/04/2021.
//

import UIKit
import CoreUIKit
@testable import RoundUp

// MARK: - Domain Specific Language Var's
extension AccountsFeedViewController {
    var table: UITableView? {
        view.findChildView(byAccessibilityIdentifier: "accounts-feed-table") as? UITableView
    }
    
    var loadingIndicator: UIRefreshControl? {
        table?.refreshControl
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

// MARK: - Domain Specific Language Functions
extension AccountsFeedViewController {
    func simulate(selectRowAtIndex rowIndex: Int, sectionIndex: Int) {
        guard let table = table else {
            assertionFailure("Epected `AccountsFeedViewController` to have a `UITableView`")
            return
        }
        let indexPath = IndexPath(item: rowIndex, section: sectionIndex)
        tableView(table, didSelectRowAt: indexPath)
    }
}
