//
//  Coordinatorable.swift
//  
//
//  Created by TM.Dev on 28/01/2022.
//  
//

import Foundation

public protocol Coordinatorable: AnyObject, AlertPresentable {
    var router: Router { get set }
}

// MARK: - Default Implementation
extension Coordinatorable {
    public func end(animated: Bool = true, completion: (() -> Void)? = nil) {
        guard let childCoordinator = self as? ChildCoordinatorable, let parentCoordinator = childCoordinator.parentCoordinator else {
            return
        }
        parentCoordinator.willEnd(childCoordinator: childCoordinator)
        parentCoordinator.router.dismissViewController(animated: animated) {
            parentCoordinator.removeChildCoordinator(coordinator: childCoordinator)
            if let completionHandler = completion {
                completionHandler()
            }
            parentCoordinator.didEnd(childCoordinator: childCoordinator)
        }
    }
}
