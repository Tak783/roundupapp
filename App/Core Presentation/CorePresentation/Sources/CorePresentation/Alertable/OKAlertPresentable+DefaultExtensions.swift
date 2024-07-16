//
//  OKAlertPresentable.swift
//  
//
//  Created by TM.Dev on 07/10/2023.
//

import CoreFeatureLayerPresentationHelpers
import Foundation
import UIKit

extension OKAlertPresentable where Self: AlertPresentable {
    public func presentOkAlert(
        title: String?, message: String?, completion: ((UIAlertAction) -> Void)? = nil) {
        let okAction = UIAlertAction(title: "OK", style: .default, handler: completion)
        presentAlertController(
            title: title,
            message: message,
            style: .alert,
            actions: [okAction],
            completion: nil
        )
    }
}
