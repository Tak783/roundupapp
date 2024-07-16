//
//  UIViewController+NavigationBar.swift
//
//
//  Created by TM.Dev on 02/04/2024.
//

import Foundation
import UIKit

extension UIViewController {
    public func hideNavigationBarSeparator() {
        navigationController?.navigationBar.shadowImage = UIImage()
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = .systemBackground
            appearance.shadowImage = nil
            appearance.shadowColor = nil
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
    }
}
