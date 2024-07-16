//
//  TotalSaved.swift
//  SavingsGoalsFeature
//
//  Created by TM.Dev on 10/07/2024.
//

import Foundation
import CoreStarlingEngineSharedModels

public struct TotalSaved: Equatable, Amountable {
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
