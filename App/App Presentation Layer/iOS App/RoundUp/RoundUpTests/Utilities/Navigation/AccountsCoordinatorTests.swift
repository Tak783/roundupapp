//
//  AccountsCoordinatorTests.swift
//  RoundUpAppTests
//
//  Created by TM.Dev on 16/04/2021.
//

import XCTest
import CoreFoundational
import CoreTesting
import MockNetworking
import CorePresentation
import AccountsFeature
@testable import RoundUp

final class AccountsCoordinatorTests: XCTestCase {
    func test_start_setsAccountsFeedAsRootViewController() {
        let sut = make_sut()
        assert(sut: sut, shows: AccountsFeedViewController.self) {
            sut.start()
        }
    }
}
 
// MARK: - AccountsCoordinatorable
extension AccountsCoordinatorTests {
    func test_navigateToAccountsFeed_setsAccountsFeedAsRootViewController() {
        let sut = make_sut()
        assert(sut: sut, shows: AccountsFeedViewController.self) {
            sut.navigateToAccountsFeed()
        }
    }
    
    func test_navigateToAccountsFeed_pushesAccountDetailFeed() {
        let data = MockData.any_data(
            for: MockData.FileName.account.rawValue,
            fromBundle: MockNetworkingPackageBundleAccessor.bundle
        )
        let account = try! JSONDecoder(with: .jsonDateTimeFormatter).decode(TestAccount.self, from: data).toModel()
        
        let sut = make_sut()
        assert(sut: sut, shows: AccountDetailViewController.self) {
            sut.navigateToAccountDetail(withAccount: account)
        }
    }
}

// MARK: - AccountsSavingsCoordinatorable
extension AccountsCoordinatorTests {
    func test_navigateToSavingsGoalFeed_presentsSavingsGoalsFeed() {
        let data = MockData.any_data(
            for: MockData.FileName.account.rawValue,
            fromBundle: MockNetworkingPackageBundleAccessor.bundle
        )
        let account = try! JSONDecoder(with: .jsonDateTimeFormatter).decode(TestAccount.self, from: data).toModel()
        
        let sut = make_sut()
        assert(sut: sut, shows: SavingsGoalFeedViewController.self, inChildCoordinator: true) {
            sut.navigateToSavingsGoalFeed(withAccount: account)
        }
    }
    
    func test_navigateToSelectSavingsGoal_presentsSelectSavingsGoalsFeed() {
        let data = MockData.any_data(
            for: MockData.FileName.account.rawValue,
            fromBundle: MockNetworkingPackageBundleAccessor.bundle
        )
        let account = try! JSONDecoder(with: .jsonDateTimeFormatter).decode(TestAccount.self, from: data).toModel()
        
        let sut = make_sut()
        assert(sut: sut, shows: SavingsGoalFeedViewController.self, inChildCoordinator: true) {
            sut.navigateToSelectSavingsGoal(for: account)
            
            _ = XCTWaiter.wait(for: [.init()], timeout: 1.0)
            
            let navigationController = sut.childCoordinators.last?.router.navigationController
            let viewController = navigationController?.viewControllers.last as? SavingsGoalFeedViewController
            XCTAssertEqual(viewController?.feedViewModel?.state, .goalSelection)
        }
    }
}

// MARK: - Make SUT
extension AccountsCoordinatorTests {
    private func make_sut() -> AccountsCoordinator {
        let client = HTTPClientSpy()
        let parentRouter = make_parentRouter()
        let parentCoordinatorStub = make_parentCoordinatorStub(withRouter: parentRouter)
        let testRouter = make_testRouter()
        
        let sut = AccountsCoordinator(router: testRouter, client: client, parentCoordinator: parentCoordinatorStub)
        attach(coordinator: sut)
        trackForMemoryLeaks(sut)
        return sut
    }
}
// MARK: - Helpers
extension AccountsCoordinatorTests {
    private func make_parentRouter() -> Router {
        let parentRouter = Router(navigationController: .init())
        trackForMemoryLeaks(parentRouter)
        return parentRouter
    }
    
    private func make_parentCoordinatorStub(withRouter router: Router) -> ParentCoordinatorStub {
        let parentCoordinatorStub = ParentCoordinatorStub(router: router)
        trackForMemoryLeaks(parentCoordinatorStub)
        return parentCoordinatorStub
    }
    
    private func make_testRouter() -> Router {
        let testRouter = Router(navigationController: .init())
        trackForMemoryLeaks(testRouter)
        return testRouter
    }
}
