//
//  UINavigationController.swift
//  
//
//  Created by TM.Dev on 17/03/2023.
//

import Foundation
import UIKit

extension UINavigationController {
    public static func defaultNavigationController(
        withModalPresentationStyle modalPresentationStyle: UIModalPresentationStyle = .fullScreen,
        navigationBarHidden: Bool = false
    ) -> UINavigationController {
        let navigationController = UINavigationController.init()
        navigationController.modalPresentationStyle = modalPresentationStyle
        navigationController.setNavigationBarHidden(navigationBarHidden, animated: false)
        navigationController.view.backgroundColor = .systemBackground
        return navigationController
    }
}
