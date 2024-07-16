//
//  AlertCreatable.swift
//  
//
//  Created by TM.Dev on 29/01/2022.
//  
//

import UIKit

public protocol AlertCreatable {
    func alertController(
        title: String?, message: String?,
        style: UIAlertController.Style, 
        actions: [UIAlertAction]
    ) -> UIAlertController
}

// MARK: - Default Implementation
extension AlertCreatable {
    public func alertController(
        title: String?,
        message: String?,
        style: UIAlertController.Style,
        actions: [UIAlertAction]
    ) -> UIAlertController {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: style
        )
        for action in actions {
            alertController.addAction(action)
        }
        return alertController
    }
}
