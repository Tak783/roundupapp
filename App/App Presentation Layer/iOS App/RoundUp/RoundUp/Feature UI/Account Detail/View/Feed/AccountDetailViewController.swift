//
//  AccountDetailViewController.swift
//  
//
//  Created by TM.Dev on 17/04/2021.
//

import AccountsFeature
import CorePresentation
import CoreUIKit
import SavingsGoalsFeature
import UIKit

final class AccountDetailViewController: UIViewController, Storyboarded {
    var feedViewModel: TransactionsFeedViewModellable?
    var headerViewModel: AccountDetailHeaderViewModellable?
    var addMoneyToSavingsGoalViewModel: AddMoneyToSavingsGoalViewModellable?
    
    @IBOutlet private var accountDetailView: AccountDetailHeaderView!
    @IBOutlet private var errorView: UIView!
    @IBOutlet private var saveRoundUpButton: UIButton!
    @IBOutlet private var searchBar: UISearchBar!
    @IBOutlet private var tableView: UITableView! {
        didSet {
            tableView.accessibilityIdentifier = "transactions-feed-table"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        loadTransactionsForLastSevenDays()
    }
}

// MARK: - Setup View
extension AccountDetailViewController {
    private func setupView() {
        setupTableView()
        bindToViewModel()
        reloadTableHeader()
    }
}

// MARK: - Bind Feed To View Models
extension AccountDetailViewController {
    func bindToViewModel() {
        bindAddMoneyToSavingsViewModel()
        bindFeedViewModel()
    }
}

// MARK: - Bind Feed To View Models
extension AccountDetailViewController {
    private func bindFeedViewModel() {
        title = feedViewModel?.title
        bindOnLoadFeedSuccess()
        bindFeedLoadingLoadError()
        bindFeedLoadingStateChange()
    }
    
    private func bindOnLoadFeedSuccess() {
        feedViewModel?.onFeedLoadSuccess = { [weak self] newRoundUpTotal in
            guard let self = self else { return }
            DispatchQueue.performOnMainThread {
                self.headerViewModel?.update(
                    withWeekRoundUpTotal: newRoundUpTotal
                )
                if let headerViewModel = self.headerViewModel {
                    self.accountDetailView.update(
                        with: headerViewModel
                    )
                }
                self.reloadTable()
                self.reloadSaveRoundUpButton()
            }
        }
    }
    
    private func bindFeedLoadingLoadError() {
        feedViewModel?.onFeedLoadError = { [weak self] error in
            guard let self = self else { return }
            DispatchQueue.performOnMainThread {
                self.errorView.isHidden = error == .none ? true : false
            }
        }
    }
    
    private func bindFeedLoadingStateChange() {
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
}

// MARK: - Bind AddMoneyToSavingsGoal View Model
extension AccountDetailViewController {
    private func bindAddMoneyToSavingsViewModel() {
        bindAddMoneyToSavingsViewModelLoadingLoadError()
        bindAddMoneyToSavingsViewModelLoadingStateChange()
        bindAddMoneyToSavingsViewModelLoadingSuccess()
    }
    
    private func bindAddMoneyToSavingsViewModelLoadingLoadError() {
        addMoneyToSavingsGoalViewModel?.onAddRequestError = { [weak self] error in
            guard let self = self else { return }
            DispatchQueue.performOnMainThread {
                self.errorView.isHidden = error == .none ? true : false
            }
        }
    }
    
    private func bindAddMoneyToSavingsViewModelLoadingStateChange() {
        addMoneyToSavingsGoalViewModel?.onAddRequestLoadingStateChange = { [weak self] isLoading in
            guard let self = self else { return }
            DispatchQueue.performOnMainThread {
                self.setAddMoneyToSavingsRequestLoadingState(isLoading)
            }
        }
    }
    
    private func bindAddMoneyToSavingsViewModelLoadingSuccess() {
        addMoneyToSavingsGoalViewModel?.onAddRequestSuccess = { [weak self] isLoading in
            guard let self = self else { return }
            DispatchQueue.performOnMainThread {
                self.feedViewModel?.didAddToSavingsGoal()
                self.loadTransactionsForLastSevenDays()
                self.reloadSaveRoundUpButton()
            }
        }
        
        feedViewModel?.onFilteredTransactionsUpdate = { [weak self] _ in
            DispatchQueue.performOnMainThread {
                self?.tableView.reloadData()
            }
        }
    }
}

// MARK: - Setup TableView
extension AccountDetailViewController {
    private func setupTableView() {
        registerCellsForTable()
        setupRefreshControl()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(
            self,
            action: #selector(handleRefresh(_:)),
            for: .valueChanged
        )
        tableView.refreshControl = refreshControl
               
    }
    
    private func registerCellsForTable() {
        let bundle = Bundle(for: TransactionTableViewCell.self)
        let nib = UINib(
            nibName: TransactionTableViewCell.className,
            bundle: bundle
        )
        tableView.register(
            nib,
            forCellReuseIdentifier: TransactionTableViewCell.className
        )
    }
}

// MARK: - Update View
extension AccountDetailViewController {
    func didSelectSavingGoalToAddRoundUpTotal(savingsGoal: SavingsGoal) {
        guard let amount = headerViewModel?.weekRoundUp.toMajorUnits() else {
            fatalError("`headerViewModel` should have a `weekRoundUp` to use this method")
        }
        addMoneyToSavingsGoalViewModel?.add(
            amount: amount,
            intoSavingsGoalUid: savingsGoal.savingsGoalUid
        )
    }
    
    private func setAddMoneyToSavingsRequestLoadingState(
        _ isLoading: Bool
    ) {
        saveRoundUpButton.isHidden = isLoading
    }
}

// MARK: - Load Feed
extension AccountDetailViewController {
    private func loadTransactionsForLastSevenDays() {
        let maxTransactionTimestamp = Date.now
        let minTransactionTimestamp = RoundupCalculator.transactionDate(
            startingAtDate: maxTransactionTimestamp,
            daysToAdd: -7
        )
        feedViewModel?.reloadTransactions(
            minTransactionTimestamp: minTransactionTimestamp,
            maxTransactionTimestamp: maxTransactionTimestamp
        )
    }
    
    private func reloadTable() {
        DispatchQueue.performOnMainThread {
            self.tableView.reloadData()
            self.reloadTableHeader()
        }
    }
    
    private func setAddMoneyToSavingsRequestLoadingState() {
        DispatchQueue.performOnMainThread {
            self.tableView.reloadData()
            self.reloadTableHeader()
            self.reloadSaveRoundUpButton()
        }
    }
    
    private func reloadTableHeader() {
        DispatchQueue.performOnMainThread {
            guard let viewModel = self.headerViewModel else {
                return
            }
            if self.isViewLoaded {
                self.accountDetailView.update(with: viewModel)
            }
        }
    }
}

// MARK: - Update Round Up Button
extension AccountDetailViewController {
    private func reloadSaveRoundUpButton() {
        guard let amount = headerViewModel?.weekRoundUp.toMajorUnits() else {
            fatalError("`headerViewModel` should have a `weekRoundUp` to use this method")
        }
        if amount == 0 {
            reloadSaveRoundUpButton(withState: .disabled)
        } else {
            reloadSaveRoundUpButton(withState: .enabled)
        }
    }
    
    private func reloadSaveRoundUpButton(withState state: RoundupButtonState) {
        self.saveRoundUpButton.setTitle(
            "Add Round Up To Savings Goal",
            for: .normal
        )
        switch state {
        case .enabled:
            self.saveRoundUpButton.backgroundColor = .link
            self.saveRoundUpButton.isEnabled = true
        case .disabled:
            self.saveRoundUpButton.backgroundColor = .lightGray
            self.saveRoundUpButton.isEnabled = false
        }
    }
}

// MARK: - UITableViewDataSource
extension AccountDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        feedViewModel?.transactionFeedItemViewModels.count ?? 0
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard
            let feedViewModel,
            feedViewModel.transactionFeedItemViewModels.indices.contains(indexPath.row) else {
            return .init()
        }
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TransactionTableViewCell.className
        ) as? TransactionTableViewCell else {
            return .init()
        }
        cell.selectionStyle = .none
        cell.update(with: feedViewModel.transactionFeedItemViewModels[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension AccountDetailViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        viewForFooterInSection section: Int
    ) -> UIView? {
        .init()
    }
}

// MARK: - UISearchBarDelegate
extension AccountDetailViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        feedViewModel?.filterTransactions(with: searchText)
    }
}

// MARK: - Button Actions
extension AccountDetailViewController {
    @IBAction private func didTouchUpInsideSavingsGoalsButton(_ sender: Any) {
        feedViewModel?.didRequestToNavigateToSavingsGoalsFeed()
    }
    
    @IBAction private func didTouchUpInsideAddToSavingsButton(_ sender: Any) {
        feedViewModel?.didRequestToSelectSavingsGoal()
    }
    
    @objc private func weakHandleRefresh(_ refreshControl: UIRefreshControl) {
        weak var weakSelf = self
        DispatchQueue.main.async {
            weakSelf?.handleRefresh(refreshControl)
        }
    }
    
    @objc private func handleRefresh(_ refreshControl: UIRefreshControl) {
        loadTransactionsForLastSevenDays()
    }
}
