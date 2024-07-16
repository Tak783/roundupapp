//
//  ViewController+MBProgressHUD.swift
//  
//
//  Created by TM.Dev on 20/03/2023.
//

import UIKit
import MBProgressHUD

// MARK: - HUD
extension UIViewController {
    @objc open func updateHUD(toShow: Bool) {
        DispatchQueue.performOnMainThread {
            if toShow {
                MBProgressHUD.showAdded(to: self.view, animated: true)
            } else {
                MBProgressHUD.hide(for: self.view, animated: true)
            }
        }
    }
}
