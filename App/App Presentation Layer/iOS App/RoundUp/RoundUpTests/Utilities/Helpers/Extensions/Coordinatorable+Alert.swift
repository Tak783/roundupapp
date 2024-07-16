//
//  Coordinatorable+Extensions.swift
//  RoundUpAppTests
//
//  Created by TM.Dev on 08/06/2021.
//

import UIKit
import CorePresentation
@testable import RoundUp

extension Coordinatorable {
    var alert: UIAlertController? {
        router.navigationController.presentedViewController as? UIAlertController
    }
}
