//
//  AccountsFeedViewModel.swift
//  AccountsFeature
//
//  Created by TM.Dev on 06/06/2021.
//

import CoreFoundational
import Foundation

public final class AccountsFeedViewModel {
    public var onLoadingStateChange: Observer<Bool>?
    public var onFeedLoadError: Observer<String?>?
    public var onFeedLoadSuccess: Observer<[Account]>?
    
    public var accountsFeedService: AccountsFeedServiceable
    public var title: String
    
    public weak var coordinator: AccountsCoordinatorable?

    public private (set) var feedItemViewModels = [AccountFeedItemViewModellable]()
    private var accountModels = [Account]()

    public init(
        accountsFeedService: AccountsFeedServiceable,
        title: String,
        coordinator: AccountsCoordinatorable?
    ) {
        self.title = title
        self.accountsFeedService = accountsFeedService
        self.coordinator = coordinator
    }
}

// MARK: - AccountsFeedViewModellable
extension AccountsFeedViewModel: AccountsFeedViewModellable {
    public func loadFeed() {
        onLoadingStateChange?(true)
        accountsFeedService.load { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(accounts):
                self.didLoadAccounts(accounts)
            case .failure(let error):
                efficientPrint(error.localizedDescription)
                self.onFeedLoadError?("Failed to Load Feed")
            }
            self.onLoadingStateChange?(false)
        }
    }
    
    public func didRequestToSeeAccount(atIndex index: Int) {
        guard accountModels.indices.contains(index) else {
            return
        }
        let accountModel = accountModels[index]
        coordinator?.navigateToAccountDetail(
            withAccount: accountModel
        )
    }
}

// MARK: - Load Accounts Helpers
extension AccountsFeedViewModel {
    private func didLoadAccounts(_ accounts: [Account]) {
        accountModels = accounts
        feedItemViewModels = Self.adaptAccountToPresentationModels(
            for: accounts
        )
        onFeedLoadError?(.none)
        onFeedLoadSuccess?(accounts)
    }
}

// MARK: - Adapt Accounts For AccountsFeedViewController
extension AccountsFeedViewModel {
    private static func adaptAccountToPresentationModels(
        for accounts: [Account]
    ) -> [AccountFeedItemViewModel] {
        return accounts.map { account in
            return AccountFeedItemViewModel(with: account)
        }
    }
}

