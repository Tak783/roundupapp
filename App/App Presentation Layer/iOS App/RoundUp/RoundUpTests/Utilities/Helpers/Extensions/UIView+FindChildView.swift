//
//  UIView+FindChildView.swift
//  RoundUpTests
//
//  Created by TM.Dev on 15/07/2024.
//

import UIKit

extension UIView {
    internal func findChildView(
        byAccessibilityIdentifier accessibilityIdentifier: String
    ) -> UIView? {
        guard let foundView = subviews.first(
            where: { $0.accessibilityIdentifier == accessibilityIdentifier }
        ) else {
            return subviews.lazy.compactMap {
                $0.findChildView(byAccessibilityIdentifier: accessibilityIdentifier)
            }.first
        }
        return foundView
    }
}

