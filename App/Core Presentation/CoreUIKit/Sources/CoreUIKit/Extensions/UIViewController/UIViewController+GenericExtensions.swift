//
//  UIViewController+GenericExtensions.swift
//
//
//  Created by TM.Dev on 21/05/2024.
//

import Foundation
import UIKit

extension UIViewController {
    public func disableSwipeDown() {
        // Disable interactive dismiss
        isModalInPresentation = true
    }
    
    public func hideTabbar() {
        tabBarController?.tabBar.isHidden = true
    }
}
