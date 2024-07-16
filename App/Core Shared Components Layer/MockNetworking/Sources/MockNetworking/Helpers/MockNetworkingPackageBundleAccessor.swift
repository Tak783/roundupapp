//
//  MockNetworkingPackageBundleAccessor.swift
//
//
//  Created by TM.Dev on 11/07/2024.
//

import CoreFoundational
import Foundation

public struct MockNetworkingPackageBundleAccessor: PackageBundleAccessing {
    public static var bundle: Bundle {
        Bundle.module
    }
}
