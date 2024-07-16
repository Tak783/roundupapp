//
//  RemoteAmount.swift
//  AccountsFeature
//
//  Created by TM.Dev on 10/07/2024.
//

import CoreStarlingEngineSharedModels
import Foundation

struct RemoteAmount: Codable, Equatable, Amountable {
    public let currency: String
    public let minorUnits: Int
}
