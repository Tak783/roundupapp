//
//  UITableView+Extensions.swift
//  RoundUpAppTests
//
//  Created by TM.Dev on 15/04/2021.
//

import UIKit

extension UITableView {
    var registeredNibs: [String: UINib] {
        let dict = value(forKey: "_nibMap") as? [String: UINib]
        return dict ?? [:]
    }

    var registeredClasses: [String: Any] {
        let dict = value(forKey: "_cellClassDict") as? [String: Any]
        return dict ?? [:]
    }
}
