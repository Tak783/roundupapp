//
//  Router.swift
//  
//
//  Created by TM.Dev on 28/01/2022.
//  
//

import Foundation
import UIKit

public final class Router: Routerable {
    public enum NavigationMethod {
        case push, present, setAsRoot
    }
    
    public private(set) var navigationController: UINavigationController

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    public func setRootViewController(viewController: UIViewController, animated: Bool = true) {
        navigationController.setViewControllers([viewController], animated: animated)
    }

    public func pushViewController(viewController: UIViewController, animated: Bool = true) {
        navigationController.pushViewController(viewController, animated: animated)
    }

    public func popViewController(animated: Bool = true) {
        navigationController.popViewController(animated: animated)
    }
    
    public func popToRootViewController(animated: Bool = true) {
        navigationController.popToRootViewController(animated: animated)
    }

    public func presentViewController(viewController: UIViewController, animated: Bool = true, completion: (() -> Void)?) {
        navigationController.present(viewController, animated: animated, completion: completion)
    }

    public func dismissViewController(animated: Bool = true, completion: (() -> Void)?) {
        navigationController.dismiss(animated: animated, completion: completion)
    }
    
    public func navigateToViewController(_ viewController: UIViewController,
                                  withMethod navigationMethod: NavigationMethod,
                                  animated: Bool = true,
                                  completion: (() -> Void)? = nil) {
        switch navigationMethod {
        case .push:
            pushViewController(viewController: viewController, animated: animated)
            guard let completion = completion else { return }
            completion()
        case .present:
            presentViewController(viewController: viewController, animated: animated, completion: completion)
        case .setAsRoot:
            setRootViewController(viewController: viewController, animated: animated)
            guard let completion = completion else { return }
            completion()
        }
    }
}
