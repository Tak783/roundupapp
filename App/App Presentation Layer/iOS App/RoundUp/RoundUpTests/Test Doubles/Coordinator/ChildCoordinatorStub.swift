//
//  ChildCoordinatorStub.swift
//  RoundUpAppTests
//
//  Created by TM.Dev on 16/04/2021.
//

import CorePresentation
@testable import RoundUp
import UIKit

final class ChildCoordinatorStub: ChildCoordinatorable {
    weak var parentCoordinator: ParentCoordinatorable?
    var router: Router

    init(router: Router, parentCoordinator: ParentCoordinatorable) {
        self.router = router
        self.parentCoordinator = parentCoordinator
    }

    func start() {
        let vc = UIViewController.init()
        vc.view.backgroundColor = .yellow
        router.setRootViewController(viewController: vc)
    }
}
