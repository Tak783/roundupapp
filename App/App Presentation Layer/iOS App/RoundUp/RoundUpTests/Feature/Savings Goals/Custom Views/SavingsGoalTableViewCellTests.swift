//
//  SavingsGoalTableViewCellTests.swift
//  RoundUpAppTests
//
//  Created by TM.Dev on 07/06/2021.
//

import XCTest
import CoreFoundational
import CoreUIKit
import CoreTesting
import MockNetworking
@testable import RoundUp

final class SavingsGoalTableViewCellTests: XCTestCase {
    func test_awakeFromNib_showsViewInDefaultState() {
        let sut = make_sut()

        sut.awakeFromNib()

        assert(sut: sut, isShowingDefaultState: true)
    }

    private func assert(sut: SavingsGoalTableViewCell, isShowingDefaultState: Bool) {
        assert(label: sut.nameLabel, isShowingDefaultState: isShowingDefaultState, isHidden: false)
        assert(label: sut.targetLabel, isShowingDefaultState: isShowingDefaultState, isHidden: false)
        assert(label: sut.totalSavedLabel, isShowingDefaultState: isShowingDefaultState, isHidden: false)
    }
}

// MARK: - Make SUT
extension SavingsGoalTableViewCellTests {
    private func make_sut() -> SavingsGoalTableViewCell {
        let nib = UINib(nibName: SavingsGoalTableViewCell.className,
                        bundle: Bundle(for: SavingsGoalTableViewCell.self))
        let sut = nib.instantiate(withOwner: self, options: nil).first as! SavingsGoalTableViewCell
        trackForMemoryLeaks(sut)
        return sut
    }
}

// MARK: - Domain Specific Language Variables
extension SavingsGoalTableViewCell {
    var nameLabel: UILabel? {
        findChildView(byAccessibilityIdentifier: "name-label") as? UILabel
    }

    var targetLabel: UILabel? {
        findChildView(byAccessibilityIdentifier: "target-label") as? UILabel
    }

    var totalSavedLabel: UILabel? {
        findChildView(byAccessibilityIdentifier: "total-saved-label") as? UILabel
    }
    
    var savedPercentageLabel: UILabel? {
        findChildView(byAccessibilityIdentifier: "saved-percentage-label") as? UILabel
    }
}

