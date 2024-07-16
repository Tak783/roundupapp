//
//  AccountFeedTableViewCellTests.swift
//  RoundUpAppTests
//
//  Created by TM.Dev on 15/04/2021.
//

import XCTest
import CoreFoundational
import CoreUIKit
import CoreTesting
import MockNetworking
@testable import RoundUp

final class AccountFeedTableViewCellTests: XCTestCase {
    func test_awakeFromNib_showsViewInDefaultState() {
        let sut = make_sut()

        sut.awakeFromNib()

        assert(sut: sut, isShowingDefaultState: true)
    }

    private func assert(sut: AccountFeedTableViewCell, isShowingDefaultState: Bool) {
        assert(label: sut.nameLabel, isShowingDefaultState: isShowingDefaultState, isHidden: false)
        assert(label: sut.currencyLabel, isShowingDefaultState: isShowingDefaultState, isHidden: false)
        assert(label: sut.createdAtLabel, isShowingDefaultState: isShowingDefaultState, isHidden: false)
    }
}

// MARK: - Make SUT
extension AccountFeedTableViewCellTests {
    private func make_sut() -> AccountFeedTableViewCell {
        let nib = UINib(nibName: AccountFeedTableViewCell.className,
                        bundle: Bundle(for: AccountFeedTableViewCell.self))
        let sut = nib.instantiate(withOwner: self, options: nil).first as! AccountFeedTableViewCell
        trackForMemoryLeaks(sut)
        return sut
    }
}

// MARK: - Domain Specific Language Variables
extension AccountFeedTableViewCell {
    var nameLabel: UILabel? {
        findChildView(byAccessibilityIdentifier: "name-label") as? UILabel
    }

    var currencyLabel: UILabel? {
        findChildView(byAccessibilityIdentifier: "currency-label") as? UILabel
    }

    var createdAtLabel: UILabel? {
        findChildView(byAccessibilityIdentifier: "created-at-label") as? UILabel
    }
}

