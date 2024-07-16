//
//  CoordinatorTestCase.swift
//  RoundUpAppTests
//
//  Created by TM.Dev on 08/06/2021.
//

import CorePresentation
import MockNetworking
@testable import RoundUp
import UIKit
import XCTest

class CoordinatorTestCase: XCTestCase {
    func make_parentRouter() -> Router {
        let parentRouter = Router(navigationController: .init())
        trackForMemoryLeaks(parentRouter)
        return parentRouter
    }
    
    func make_parentCoordinatorStub(withRouter router: Router) -> ParentCoordinatorStub {
        let parentCoordinatorStub = ParentCoordinatorStub(router: router)
        trackForMemoryLeaks(parentCoordinatorStub)
        return parentCoordinatorStub
    }
    
    func make_testRouter() -> Router {
        let testRouter = Router(navigationController: .init())
        trackForMemoryLeaks(testRouter)
        return testRouter
    }
}
