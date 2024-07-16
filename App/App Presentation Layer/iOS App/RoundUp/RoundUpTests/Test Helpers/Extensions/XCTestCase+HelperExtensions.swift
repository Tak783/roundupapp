//
//  XCTestCase+HelperExtensions.swift
//  RoundUpAppTests
//
//  Created by Tak M on 17/04/2021.
//

import CorePresentation
import Foundation
@testable import RoundUp
import UIKit
import XCTest

extension XCTestCase {
    func assert<T>(sut: Coordinatorable,
                   shows controller: T.Type,
                   inChildCoordinator: Bool = false,
                   when action: () -> Void,
                   file: StaticString = #file,
                   line: UInt = #line) {
        action()
        var navigationController: UINavigationController? = sut.router.navigationController
        if inChildCoordinator, let parentCoordinator = sut as? ParentCoordinatorable {
            navigationController = parentCoordinator.childCoordinators.last?.router.navigationController
        }
        if navigationController?.viewControllers.last as? T == nil {
            let receivedClassName = String(describing: navigationController?.viewControllers.last)
            XCTFail("Expected first view controller to be a \(controller), received \(receivedClassName)", file: file, line: line)
            return
        }
    }

    func assert(label: UILabel?,
                isShowingDefaultState: Bool,
                state: String = "-",
                isHidden: Bool,
                file: StaticString = #file,
                line: UInt  = #line) {
        let messagePrefix = "Expected Label with Identifier \(label?.accessibilityIdentifier ?? "Which is not known") "
        let defaultStateMessage = "\(messagePrefix) to \(isShowingDefaultState ? "" : "not ")show default State: `\(state)`"
        let hiddenMessage = "\(messagePrefix) to \(isHidden ? "" : "not ")be hidden"

        XCTAssert((label?.text == state) == isShowingDefaultState, defaultStateMessage, file: file, line: line)
        XCTAssertEqual(label?.isHidden, isHidden, hiddenMessage, file: file, line: line)
    }
}
