//
//  SavingsGoalsCoordinatorTests.swift
//  RoundUpAppTests
//
//  Created by TM.Dev on 08/06/2021.
//

import XCTest
import CoreFoundational
import CoreTesting
import CoreNetworking
import MockNetworking
import SavingsGoalsFeature
import AccountsFeature
@testable import RoundUp

final class SavingsGoalsCoordinatorTests: CoordinatorTestCase {
    func test_start_showsSavingsGoalsFeedAsRootViewController() {
        let sutState = SavingsGoalFeedViewModelViewState.normal
        let sut = make_sut()
        assert(sut: sut, shows: SavingsGoalFeedViewController.self) {
            sut.navigateToSavingsGoalFeed(forState: sutState)
        }
        
        let sut2State = SavingsGoalFeedViewModelViewState.goalSelection
        let sut2 = make_sut()
        assert(sut: sut2, shows: SavingsGoalFeedViewController.self) {
            sut2.navigateToSavingsGoalFeed(forState: sut2State)
            
            let viewController = sut2.router.navigationController.viewControllers.last as? SavingsGoalFeedViewController
            XCTAssertEqual(viewController?.feedViewModel?.state, sut2State)
        }
    }
}

// MARK: - Make SUT
extension SavingsGoalsCoordinatorTests {
    private func make_sut() -> SavingsGoalsCoordinator {
        let accountResponseData = MockData.any_data(
            for: MockData.FileName.account.rawValue,
            fromBundle: MockNetworkingPackageBundleAccessor.bundle
        )
        let account = try! JSONDecoder(with: .jsonDateTimeFormatter).decode(TestAccount.self, from: accountResponseData).toModel()
        
        let client = HTTPClientSpy()
        let parentRouter = make_parentRouter()
        let parentCoordinatorStub = make_parentCoordinatorStub(withRouter: parentRouter)
        let testRouter = make_testRouter()
        
        let sut = SavingsGoalsCoordinator(router: testRouter, account: account, client: client, parentCoordinator: parentCoordinatorStub)
        attach(coordinator: sut)
        trackForMemoryLeaks(sut)
        return sut
    }
}
