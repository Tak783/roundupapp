//
//  SourceAmount.swift
//
//
//  Created by TM.Dev on 12/07/2024.
//

import CoreStarlingEngineSharedModels
import Foundation

public struct SourceAmount: Amountable, Equatable {
    public private(set) var currency: String
    public private(set) var minorUnits: Int
    
    public init(
        currency: String,
        minorUnits: Int
    ) {
        self.currency = currency
        self.minorUnits = minorUnits
    }
}
