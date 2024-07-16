//
//  RouterTests.swift
//  RoundUpAppTests
//
//  Created by TM.Dev on 16/04/2021.
//

import CorePresentation
@testable import RoundUp
import XCTest

class RouterTests: XCTestCase {
    func test_init() {
        let sut = make_sut()
        XCTAssertNotNil(sut.navigationController)
    }
    
    func test_navigateToViewController_withMethodSetRoot_setsNewRootViewController() {
        let sut = make_sut()
        assert(sut: sut, hasViewControllerCount: 0, andController: nil, atIndex: 0)
        
        let rootViewController1 = UIViewController()
        sut.navigateToViewController(rootViewController1, withMethod: .setAsRoot, animated: false)
        assert(sut: sut, hasViewControllerCount: 1, andController: rootViewController1, atIndex: 0)
        
        let rootViewController2 = UIViewController()
        sut.navigateToViewController(rootViewController2, withMethod: .setAsRoot, animated: false)
        assert(sut: sut, hasViewControllerCount: 1, andController: rootViewController2, atIndex: 0)
        
        let rootViewController3 = UIViewController()
        sut.navigateToViewController(rootViewController3, withMethod: .setAsRoot, animated: false)
        assert(sut: sut, hasViewControllerCount: 1, andController: rootViewController3, atIndex: 0)
    }
    
    func test_navigateToViewController_withMethodPush_pushesViewController() {
        let sut = make_sut()
        assert(sut: sut, hasViewControllerCount: 0, andController: nil, atIndex: 0)
        
        let pushedViewController1 = UIViewController()
        sut.navigateToViewController(pushedViewController1, withMethod: .push, animated: false)
        assert(sut: sut, hasViewControllerCount: 1, andController: pushedViewController1, atIndex: 0)
        
        let pushedViewController2 = UIViewController()
        sut.navigateToViewController(pushedViewController2, withMethod: .push, animated: false)
        assert(sut: sut, hasViewControllerCount: 2, andController: pushedViewController2, atIndex: 1)
        
        let pushedViewController3 = UIViewController()
        sut.navigateToViewController(pushedViewController3, withMethod: .push, animated: false)
        assert(sut: sut, hasViewControllerCount: 3, andController: pushedViewController3, atIndex: 2)
    }
    
//    func test_navigateToViewController_withMethodPresent_presentsViewController() {
//        let sut = make_sut()
//
//        let viewController1 = UIViewController()
//        sut.navigateToViewController(viewController1, withMethod: .push, animated: false)
//        assert(sut: sut, hasViewControllerCount: 1, andController: viewController1, atIndex: 0)
//
//        let presentedViewController1 = UIViewController()
//        sut.navigateToViewController(presentedViewController1, withMethod: .present, animated: false)
//        _ = XCTWaiter.wait(for: [.init()], timeout: 2.0)
//        assert(sut: sut, isPresentingViewController: presentedViewController1)
//
//        let presentedViewController2 = UIViewController()
//        sut.navigateToViewController(presentedViewController2, withMethod: .present, animated: false)
//        _ = XCTWaiter.wait(for: [.init()], timeout: 2.0)
//        assert(sut: sut, isPresentingViewController: presentedViewController2)
//    }
    
    private func assert(sut: Router,
                        isPresentingViewController viewController: UIViewController?,
                        file: StaticString = #file, line: UInt  = #line) {
        XCTAssertEqual(sut.navigationController.topViewController, viewController, file: file, line: line)
    }
    
    private func assert(sut: Router,
                        hasViewControllerCount viewControllerCount: Int,
                        andController viewController: UIViewController?,
                        atIndex controllerIndex: Int,
                        file: StaticString = #file, line: UInt  = #line) {
        XCTAssertEqual(sut.navigationController.viewControllers.count, viewControllerCount, file: file, line: line)
        if viewController != nil {
            XCTAssertEqual(sut.navigationController.viewControllers[controllerIndex], viewController, file: file, line: line)
        }
    }

    private func make_sut() -> Router {
        let sut = Router(navigationController: .init())
        trackForMemoryLeaks(sut)
        return sut
    }
}
