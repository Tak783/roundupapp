//
//  ParentCoordinatorable.swift
//  
//
//  Created by TM.Dev on 28/01/2022.
//  
//

import Foundation
import os

public protocol ParentCoordinatorable: Coordinatorable {
    var childCoordinators: [ChildCoordinatorable] { get set }
    
    func willEnd(childCoordinator: ChildCoordinatorable)
    func didEnd(childCoordinator: ChildCoordinatorable)
}

// MARK: - Default Implementation
extension ParentCoordinatorable {
    public func openChild(_ childCoordinator: ChildCoordinatorable) {
        addChildCoordinator(coordinator: childCoordinator)
        router.presentViewController(
            viewController: childCoordinator.router.navigationController,
            completion: nil
        )
    }

    public func addChildCoordinator(coordinator: ChildCoordinatorable) {
        guard childCoordinators.contains(where: { $0 === coordinator }) == false else {
            return
        }
        childCoordinators.append(coordinator)
    }

    public func removeChildCoordinator(coordinator: ChildCoordinatorable) {
        guard childCoordinators.isEmpty == false else {
            return
        }
        childCoordinators.removeAll(where: { $0 === coordinator })
    }

    public func willEnd(childCoordinator: ChildCoordinatorable) {
        os_log("Did End ChildCoordinator: %@")
    }
}
