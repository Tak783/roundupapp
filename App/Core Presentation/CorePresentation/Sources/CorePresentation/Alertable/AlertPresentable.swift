//
//  AlertPresentable.swift
//  
//
//  Created by TM.Dev on 29/01/2022.
//  
//

import UIKit

public protocol AlertPresentable: AlertCreatable {
    var router: Router { get }
    
    func presentOkAlert(
        title: String?,
        message: String?,
        completion: (() -> Void)?
    )
    
    func presentAlertController(
        title: String?,
        message: String?,
        style: UIAlertController.Style,
        actions: [UIAlertAction],
        completion: (() -> Void)?
    )
}

// MARK: Default Implementation
extension AlertPresentable {
    public func presentOkAlert(
        title: String?,
        message: String?,
        completion: (() -> Void)? = nil
    ) {
        let okAction = UIAlertAction(
            title: "OK",
            style: .default) { action in
                completion?()
            }
        
        presentAlertController(
            title: title,
            message: message,
            style: .alert,
            actions: [okAction],
            completion: nil
        )
    }
    
    public func presentAlertController(
        title: String?,
        message: String?,
        style: UIAlertController.Style,
        actions: [UIAlertAction], completion: (() -> Void)?
    ) {
        let alertController = self.alertController(
            title: title,
            message: message,
            style: style,
            actions: actions
        )
        let _ = router.navigationController.viewControllers.last?.updateHUD(
            toShow: false
        )
        router.navigateToViewController(
            alertController,
            withMethod: .present,
            animated: true,
            completion: completion
        )
    }
}
