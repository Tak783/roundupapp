//
//  AccountsFeedViewControllerTests.swift
//  RoundUpAppTests
//
//  Created by TM.Dev on 12/04/2021.
//

import XCTest
import CoreFoundational
import CoreTesting
import MockNetworking
@testable import RoundUp

final class AccountsFeedViewControllerTests: XCTestCase {
    func test_initialState() {
        let sut = make_sut()

        test_title_isCorrect(for: sut)
        test_outlets_connected(for: sut)
        test_table_isSetup(for: sut)
        XCTAssertEqual(sut.isShowingErrorState, false, "Should Not Be Showing Error State")
    }
}

// MARK: - Make SUT
extension AccountsFeedViewControllerTests {
    private func make_sut() -> AccountsFeedViewController {
        let bundle = Bundle(for: AccountsFeedViewController.self)
        let storyboard = UIStoryboard(
            name: "AccountsFeed",
            bundle: bundle
        )
        let sut = storyboard.instantiateViewController(
            identifier: AccountsFeedViewController.className
        ) as! AccountsFeedViewController
        trackForMemoryLeaks(sut)
        sut.loadViewIfNeeded()
        return sut
    }
}

// MARK: - Test Helpers
extension AccountsFeedViewControllerTests {
    private func test_title_isCorrect(for sut: AccountsFeedViewController, file: StaticString = #file, line: UInt  = #line) {
        XCTAssertEqual(sut.navigationItem.title, "Accounts", file: file, line: line)
    }

    private func test_outlets_connected(for sut: AccountsFeedViewController, file: StaticString = #file, line: UInt  = #line) {
        XCTAssertNotNil(sut.table, "Table should not be nil", file: file, line: line)
        XCTAssertNotNil(sut.loadingIndicator, "Loading Indicator should not be nil", file: file, line: line)
        XCTAssertNotNil(sut.errorView, "Error View should not be nil", file: file, line: line)
    }

    private func test_table_isSetup(for sut: AccountsFeedViewController, file: StaticString = #file, line: UInt  = #line) {
        XCTAssertNotNil(sut.table?.dataSource, "Table DataSource should not be nil", file: file, line: line)
        XCTAssertNotNil(sut.table?.delegate, "Table Delegate should not be nil", file: file, line: line)

        let expectedSections = 1
        let expectedRows = 0
        XCTAssertEqual(sut.table?.numberOfSections, expectedSections, "Table should have \(expectedSections) sections", file: file, line: line)
        XCTAssertEqual(sut.table?.numberOfRows(inSection: 0), expectedRows, "Table should have \(expectedRows) rows", file: file, line: line)
        XCTAssertEqual(sut.table?.registeredNibs.first?.key, AccountFeedTableViewCell.className, file: file, line: line)
    }
    
    private func assertViewModelSetupCorrectly(sut: AccountsFeedViewController, file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertNotNil(sut.feedViewModel?.onFeedLoadError,
                        "`feedViewModel.onFeedLoadError` should be not nil", file: file, line: line)
        XCTAssertNotNil(sut.feedViewModel?.onFeedLoadSuccess,
                        "`feedViewModel.onFeedLoadSuccess` should be not nil", file: file, line: line)
        XCTAssertNotNil(sut.feedViewModel?.onLoadingStateChange,
                        "`feedViewModel.onLoadingStateChange` should be not nil", file: file, line: line)
    }
}
