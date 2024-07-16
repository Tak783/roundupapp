//
//  ParentCoordinatorStub.swift
//  RoundUpAppTests
//
//  Created by TM.Dev on 16/04/2021.
//

import CorePresentation
@testable import RoundUp
import UIKit

final class ParentCoordinatorStub: ParentCoordinatorable {
    var router: Router
    var childCoordinators = [ChildCoordinatorable]()

    init(router: Router) {
        self.router = router
    }

    func start() {
        let vc = UIViewController.init()
        vc.view.backgroundColor = .green
        router.setRootViewController(viewController: vc)
    }
    
    func didEnd(childCoordinator: CorePresentation.ChildCoordinatorable) {}
}
