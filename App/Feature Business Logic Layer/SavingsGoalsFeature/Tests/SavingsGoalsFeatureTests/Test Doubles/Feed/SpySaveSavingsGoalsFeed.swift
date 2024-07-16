//
//  SpyAddMoneyToSavingsGoalsFeed.swift
//
//
//  Created by TM.Dev on 15/07/2024.
//

import XCTest
import CoreFoundational
import CoreTesting
import CoreNetworking
import MockNetworking
import SavingsGoalsFeature

final class SpyAddMoneyToSavingsGoalsFeed: NSObject {
    var isLoading = false
    var error: String?
    var didSave = false
    
    var viewModel: AddMoneyToSavingsGoalViewModel
    
    init(viewModel: AddMoneyToSavingsGoalViewModel) {
        self.viewModel = viewModel
        super.init()
        
        bind()
    }
    
    func bind() {
        viewModel.onAddRequestLoadingStateChange = { [weak self] isLoading in
            guard let self = self else { return }
            self.isLoading = isLoading
        }
        
        viewModel.onAddRequestError = { [weak self] error in
            guard let self = self else { return }
            self.error = error
        }
        
        viewModel.onAddRequestSuccess = { [weak self] _ in
            guard let self = self else { return }
            self.didSave = true
        }
    }
}

