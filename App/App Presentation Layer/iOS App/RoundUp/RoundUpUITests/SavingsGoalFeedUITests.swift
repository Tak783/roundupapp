//
//  RoundUpUITests.swift
//  RoundUpUITests
//
//  Created by TM.Dev on 11/07/2024.
//

import XCTest

final class SavingsGoalFeedUITests: XCTestCase {
    private var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func test_accountsFeed_displaysAccountsFeed() {
        let table = app.tables["accounts-feed-table"]
        XCTAssertTrue(table.waitForExistence(timeout: 5), "Accounts feed table should exist")
        
        test_accountsFeed_hasOneValidCell(forTable: table)
    }
}

// MARK: - Supporting Tests
extension SavingsGoalFeedUITests {
    private func test_accountsFeed_hasOneValidCell(forTable table: XCUIElement) {
        let firstCell = table.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.waitForExistence(timeout: 5), "There should be at least one cell in the table")

        test_accountsFeedCell_hasValidElements(forCell: firstCell)
    }
    
    private func test_accountsFeedCell_hasValidElements(forCell cell: XCUIElement) {
        let nameLabel = cell.staticTexts["name_label"]
        let currencyLabel = cell.staticTexts["currency_label"]
        let createdAtLabel = cell.staticTexts["created_at_label"]

        XCTAssertTrue(nameLabel.exists, "Name label should be present in the cell")
        XCTAssertTrue(currencyLabel.exists, "Currency label should be present in the cell")
        XCTAssertTrue(createdAtLabel.exists, "Created At label should be present in the cell")
    }
}
