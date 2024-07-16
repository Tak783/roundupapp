//
//  UserDefaultsAuthenticationStore.swift
//  CoreNetworking
//
//  Created by TM.Dev on 05/06/2021.
//

import Foundation

public class UserDefaultsAuthenticationStore: AuthenticationStoreable {
    public var accessToken: String?
    public var refreshToken: String?
    
    public init(accessToken: String? = nil, refreshToken: String? = nil) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
}
