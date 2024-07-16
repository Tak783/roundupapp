//
//  OKAlertPresentable.swift
//  
//
//  Created by TM.Dev on 12/07/2024.
//

import Foundation

public protocol OKAlertPresentable {
    func presentOkAlert(
        title: String?,
        message: String?,
        completion: (() -> Void)?
    )
}
