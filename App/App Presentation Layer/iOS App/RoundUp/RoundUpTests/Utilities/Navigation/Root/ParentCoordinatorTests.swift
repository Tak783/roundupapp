//
//  CoordinatorTests.swift
//  RoundUpAppTests
//
//  Created by TM.Dev on 16/04/2021.
//

import XCTest
import CoreFoundational
import CorePresentation
import CoreTesting
@testable import RoundUp

class ParentCoordinatorTests: XCTestCase {
    func test_openChild_opensChildCoordiator() {
        let sut = make_sut()
        let childCoordinator = make_childCoordinator(fromParent: sut)

        sut.openChild(childCoordinator)

        XCTAssertEqual(sut.childCoordinators.count, 1)
        XCTAssertNotNil(sut.router.navigationController.presentedViewController)
    }

    private func make_sut() -> ParentCoordinatorStub {
        let testRouter = Router(navigationController: .init())
        trackForMemoryLeaks(testRouter)

        let sut = ParentCoordinatorStub(router: testRouter)
        trackForMemoryLeaks(sut)
        attach(coordinator: sut)

        return sut
    }

    private func make_childCoordinator(fromParent parentCoordinator: ParentCoordinatorable) -> ChildCoordinatorStub {
        let testRouter = Router(navigationController: .init())
        trackForMemoryLeaks(testRouter)

        let childCoordinator = ChildCoordinatorStub(router: testRouter, parentCoordinator: parentCoordinator)
        trackForMemoryLeaks(childCoordinator)
        attach(coordinator: childCoordinator)

        return childCoordinator
    }
}
