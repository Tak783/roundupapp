//
//  MockAuthenticationStore.swift
//  CoreNetworkingTests
//
//  Created by TM.Dev on 06/06/2021.
//

import Foundation
import CoreNetworking

public final class MockAuthenticationStore: AuthenticationStoreable {
    public var accessToken: String?
    public var refreshToken: String?

    public init(accessToken: String? = nil, refreshToken: String? = nil) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
}
