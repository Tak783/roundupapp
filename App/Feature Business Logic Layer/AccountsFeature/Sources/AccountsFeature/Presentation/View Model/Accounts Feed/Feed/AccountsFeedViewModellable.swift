//
//  AccountsFeedViewModellable.swift
//  AccountsFeature
//
//  Created by TM.Dev on 06/06/2021.
//

import CoreFoundational
import Foundation

public protocol AccountsFeedViewModellable: AnyObject {
    var title: String { get set }
    
    var onLoadingStateChange: Observer<Bool>? { get set }
    var onFeedLoadError: Observer<String?>? { get set }
    var onFeedLoadSuccess: Observer<[Account]>? { get set }

    var feedItemViewModels: [AccountFeedItemViewModellable] { get }
    
    var accountsFeedService: AccountsFeedServiceable { get set }
    var coordinator: AccountsCoordinatorable? { get set }
    
    func loadFeed()
    func didRequestToSeeAccount(atIndex index: Int)
}
