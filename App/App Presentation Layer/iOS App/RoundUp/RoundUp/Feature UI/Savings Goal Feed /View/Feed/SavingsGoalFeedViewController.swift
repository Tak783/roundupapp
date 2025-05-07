//
//  SavingsGoalFeedViewController.swift
//  RoundUpApp
//
//  Created by TM.Dev on 08/06/2021.
//

import AccountsFeature
import CorePresentation
import CoreUIKit
import SavingsGoalsFeature
import UIKit

final class SavingsGoalFeedViewController: UIViewController, Storyboarded {
    var feedViewModel: SavingsGoalFeedViewModellable?
    var saveSavingsGoalViewModel: SaveSavingsGoalViewModellable?
    private lazy var activityIndicator: UIActivityIndicatorView = {
        UIActivityIndicatorView(frame: .init(x: 0, y: 0, width: 20, height: 20))
    }()
    
    private lazy var addSavingsBarButtonItem: UIBarButtonItem = {
        UIBarButtonItem(
            title: "New",
            style: .plain,
            target: self,
            action: #selector(didTouchUpInsideAddNewSavingsGoalButton)
        )
    }()
    
    @IBOutlet private var errorView: UIView!
    @IBOutlet private var tableView: UITableView! {
        didSet {
            tableView.accessibilityIdentifier = "savings_goals_feed_table"
        }
    }
    
    // MARK: - UIViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindToViewModels()
        feedViewModel?.loadFeed()
    }
}

// MARK: - Setup View
extension SavingsGoalFeedViewController {
    private func setupView() {
        updateView(
            forState: feedViewModel?.state ?? .normal
        )
        showSaveSavingGoalLoadingState(false)
        setupRefreshControl()
        setupTableView()
    }

    private func setupRefreshControl() {
        tableView.refreshControl = UIRefreshControl() // TODO: - Test and Build Pull to Refresh
    }
}

// MARK: - Actions
extension SavingsGoalFeedViewController {
    @objc private func didTouchUpInsideAddNewSavingsGoalButton() {
        presentAddNewSavingsGoalForm()
    }
}

// MARK: - Update View
extension SavingsGoalFeedViewController {
    private func showSaveSavingGoalLoadingState(_ isLoading: Bool) {
        if isLoading {
            activityIndicator.startAnimating()
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                customView: activityIndicator
            )
        } else {
            activityIndicator.stopAnimating()
            showCorrectRightBarButtonItem(
                forState: feedViewModel?.state ?? .normal
            )
        }
    }
    
    private func showCorrectRightBarButtonItem(
        forState state: SavingsGoalFeedViewModelViewState = .normal
    ) {
        switch state {
        case .normal:
            showAddBarButtonItem()
        case .goalSelection:
            removeRightBarButtonItem()
        }
    }
    
    private func updateView(
        forState state: SavingsGoalFeedViewModelViewState = .normal
    ) {
        if isViewLoaded {
            tableView.allowsSelection = state == .goalSelection ? true : false
            showCorrectRightBarButtonItem(forState: state)
        }
    }
    
    private func showAddBarButtonItem() {
        navigationItem.rightBarButtonItem = addSavingsBarButtonItem
    }
    
    private func removeRightBarButtonItem() {
        navigationItem.rightBarButtonItem = nil
    }
}

// MARK: - Bind View
extension SavingsGoalFeedViewController {
    private func bindToViewModels() {
        bindFeedViewModel()
        bindSavingsGoalViewModel()
    }
}

// MARK: - Bind Feed View To FeedViewModel
extension SavingsGoalFeedViewController {
    private func bindFeedViewModel() {
        title = feedViewModel?.title
        updateView(forState: feedViewModel?.state ?? .normal)
        bindLoadingState()
        bindFeedLoadErrorState()
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
    
    private func bindFeedLoadSuccessState() {
        feedViewModel?.onFeedLoadSuccess = { [weak self] _ in
            guard let self = self else { return }
            DispatchQueue.performOnMainThread {
                self.tableView.reloadData()
            }
        }
    }
    
    private func bindFeedLoadErrorState() {
        feedViewModel?.onFeedLoadError = { [weak self] error in
            guard let self = self else { return }
            DispatchQueue.performOnMainThread {
                self.errorView.isHidden = error == .none ? true : false
            }
        }
    }
}

// MARK: - Bind Feed View To SaveSavingsViewModel
extension SavingsGoalFeedViewController {
    private func bindSavingsGoalViewModel() {
        bindSaveSavingsGoalLoadingState()
        bindSaveSavingsGoalErrorState()
        bindSaveSavingsSuccess()
    }
    
    private func bindSaveSavingsGoalLoadingState() {
        saveSavingsGoalViewModel?.onSaveRequestLoadingStateChange = { [weak self] isLoading in
            guard let self = self else { return }
            DispatchQueue.performOnMainThread {
                self.showSaveSavingGoalLoadingState(isLoading)
            }
        }
    }
    
    private func bindSaveSavingsGoalErrorState() {
        saveSavingsGoalViewModel?.onSaveRequestError = { [weak self] error in
            guard let self = self else { return }
            DispatchQueue.performOnMainThread {
                self.errorView.isHidden = error == .none ? true : false
            }
        }
    }
    
    private func bindSaveSavingsSuccess() {
        saveSavingsGoalViewModel?.onSaveRequestSuccess = { [weak self] _ in
            guard let self = self else { return }
            DispatchQueue.performOnMainThread {
                self.feedViewModel?.loadFeed()
            }
        }
    }
}

// MARK: - Bind View
extension SavingsGoalFeedViewController {
    // P1-0003: Did not write tests for this, for it is such an MVP feature
    private func presentAddNewSavingsGoalForm(
        withGoalName goalName: String = .empty,
        goalTarget: String = .empty
    ) {
        saveSavingsGoalViewModel?.didRequestToPresentNewSavingsGoalForm(
            withGoalName: goalName,
            goalTarget: goalTarget,
            completion: { [weak self] goalNameEntry, goalTargetEntry in
                guard let self = self else { return }
                DispatchQueue.performOnMainThread {
                    guard
                        goalNameEntry.isEmpty == false,
                        goalTargetEntry.isEmpty == false,
                        let target = Double(goalTargetEntry) else
                    {
                        self.presentAddNewSavingsGoalForm(
                            withGoalName: goalNameEntry,
                            goalTarget: goalTargetEntry
                        )
                        return
                    }
                    self.saveSavingsGoalViewModel?.saveSavingsGoal(
                        withName: goalNameEntry,
                        target: target
                    )
                }
            }
        )
    }
}

// MARK: - Reload View
extension SavingsGoalFeedViewController {
    private func reloadTable() {
        DispatchQueue.performOnMainThread {
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource
extension SavingsGoalFeedViewController {
    private func setupTableView() {
        registerCellsForTable()
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func registerCellsForTable() {
        let bundle = Bundle(for: SavingsGoalTableViewCell.self)
        let nib = UINib(nibName: SavingsGoalTableViewCell.className, bundle: bundle)
        tableView.register(nib, forCellReuseIdentifier: SavingsGoalTableViewCell.className)
    }
}

// MARK: - UITableViewDataSource
extension SavingsGoalFeedViewController: UITableViewDataSource {
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
            withIdentifier: SavingsGoalTableViewCell.className
        ) as? SavingsGoalTableViewCell else {
            return .init()
        }
        cell.selectionStyle = .none
        cell.update(with: feedViewModel.feedItemViewModels[indexPath.row])
        return cell
    }
}

extension SavingsGoalFeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView()
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(
            at: indexPath,
            animated: true
        )
        feedViewModel?.didRequestToAddRoundUpToSavingsGoal(
            atIndex: indexPath.row
        )
    }
}
