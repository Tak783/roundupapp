//
//  SaveSpySavingsGoalsFeed.swift
//
//
//  Created by TM.Dev on 15/07/2024.
//

import SavingsGoalsFeature
import XCTest

final class SpySaveSavingsGoalsFeed: NSObject {
    var isLoading = false
    var error: String?
    var didSave = false
    
    var viewModel: SaveSavingsGoalViewModel
    
    init(viewModel: SaveSavingsGoalViewModel) {
        self.viewModel = viewModel
        super.init()
        
        bind()
    }
    
    func bind() {
        viewModel.onSaveRequestLoadingStateChange = { [weak self] isLoading in
            guard let self = self else { return }
            self.isLoading = isLoading
        }
        
        viewModel.onSaveRequestError = { [weak self] error in
            guard let self = self else { return }
            self.error = error
        }
        
        viewModel.onSaveRequestSuccess = { [weak self] savingsGoals in
            guard let self = self else { return }
            self.didSave = true
        }
    }
}
