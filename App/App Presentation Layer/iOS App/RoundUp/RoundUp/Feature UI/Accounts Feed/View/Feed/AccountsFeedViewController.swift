//
//  AccountsFeedViewController.swift
//  RoundUp
//
//  Created by TM.Dev on 12/07/2024.
//

import Foundation
import AccountsFeature
import CoreFoundational
import CorePresentation
import UIKit

final class AccountsFeedViewController: UIViewController, Storyboarded {
    var feedViewModel: AccountsFeedViewModellable?
    
    @IBOutlet private var errorView: UIView!
    @IBOutlet private var tableView: UITableView! {
        didSet {
            tableView.accessibilityIdentifier = "accounts-feed-table"
        }
    }
    
    // MARK: - UIViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        loadAccounts()
    }
}

// MARK: - Setup View
extension AccountsFeedViewController {
    private func setupView() {
        setupRefreshControl()
        setupTableView()
        bindViewModels()
    }

    private func setupRefreshControl() {
        tableView.refreshControl = UIRefreshControl()
    }
}

// MARK: - Bind View
extension AccountsFeedViewController {
    private func bindViewModels() {
        title = feedViewModel?.title

        bindLoadingState()
        bindLoadingErrorState()
        bindFeedLoadSuccessState()
    }

    private func bindLoadingState() {
        feedViewModel?.onLoadingStateChange = { [weak self] isLoading in
            guard let self = self else { return }
            DispatchQueue.performOnMainThread {
                if isLoading {
                    self.tableView.refreshControl?.beginRefreshing()
                } else {
                    self.tableView.refreshControl?.endRefreshing()
                }
            }
        }
    }

    private func bindLoadingErrorState() {
        feedViewModel?.onFeedLoadError = { [weak self] error in
            guard let self = self else { return }
            DispatchQueue.performOnMainThread {
                self.errorView.isHidden = error == .none ? true : false
            }
        }
    }
    
    private func bindFeedLoadSuccessState() {
        feedViewModel?.onFeedLoadSuccess = { [weak self] isLoading in
            guard let self = self else { return }
            DispatchQueue.performOnMainThread {
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: - Reload View
extension AccountsFeedViewController {
    private func loadAccounts() {
        feedViewModel?.loadFeed()
    }
    
    private func reloadTable() {
        DispatchQueue.performOnMainThread {
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource
extension AccountsFeedViewController {
    private func setupTableView() {
        registerCellsForTable()
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func registerCellsForTable() {
        let bundle = Bundle(for: AccountFeedTableViewCell.self)
        let nib = UINib(
            nibName: AccountFeedTableViewCell.className,
            bundle: bundle
        )
        tableView.register(
            nib,
            forCellReuseIdentifier: AccountFeedTableViewCell.className
        )
    }
}

// MARK: - UITableViewDataSource
extension AccountsFeedViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        feedViewModel?.feedItemViewModels.count ?? 0
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard
            let feedViewModel,
            feedViewModel.feedItemViewModels.indices.contains(indexPath.row) else {
            return .init()
        }
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: AccountFeedTableViewCell.className
        ) as? AccountFeedTableViewCell else {
            return .init()
        }
        cell.selectionStyle = .none
        cell.update(with: feedViewModel.feedItemViewModels[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension AccountsFeedViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        viewForFooterInSection section: Int
    ) -> UIView? {
        .init()
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: false)
        guard let feedViewModel else {
            return
        }
        feedViewModel.didRequestToSeeAccount(
            atIndex: indexPath.row
        )
    }
}
