//
//  AccountDetailHeaderViewModellable.swift
//  AccountsFeature
//
//  Created by TM.Dev on 06/06/2021.
//

import CoreStarlingEngineSharedModels
import Foundation

public protocol AccountDetailHeaderViewModellable: AnyObject {
    var id: String { get }
    var name: String { get }
    var weekRoundUpTotal: String { get }
    var weekRoundUp: Amountable { get }
    
    func update(
        withWeekRoundUpTotal weekRoundUpTotal: Amountable
    )
}
