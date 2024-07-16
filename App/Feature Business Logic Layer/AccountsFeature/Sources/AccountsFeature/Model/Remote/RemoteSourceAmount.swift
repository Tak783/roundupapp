//
//  RemoteSourceAmount.swift
//  AccountsFeature
//
//  Created by TM.Dev on 10/07/2024.
//

import Foundation
import CoreStarlingEngineSharedModels

struct RemoteSourceAmount: Codable, Equatable, Amountable {
    public let currency: String
    public let minorUnits: Int
}
