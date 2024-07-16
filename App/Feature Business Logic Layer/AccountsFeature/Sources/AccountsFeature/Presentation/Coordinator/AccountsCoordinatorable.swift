//
//  AccountsCoordinatorable.swift
//
//
//  Created by TM.Dev on 12/07/2024.
//

public protocol AccountsCoordinatorable: AnyObject {
    func navigateToAccountsFeed()
    func navigateToAccountDetail(withAccount account: Account)
}
