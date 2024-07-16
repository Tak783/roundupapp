//
//  NavigationHelpers.swift
//  RoundUpAppTests
//
//  Created by TM.Dev on 17/04/2021.
//

import CorePresentation
@testable import RoundUp
import UIKit
import XCTest

func attach(coordinator: Coordinatorable) {
    let window = UIWindow(frame: UIScreen.main.bounds)
    window.rootViewController = coordinator.router.navigationController
    window.makeKeyAndVisible()
}
