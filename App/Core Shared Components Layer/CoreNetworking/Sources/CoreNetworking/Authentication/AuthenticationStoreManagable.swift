//
//  AuthenticationStoreManagable.swift
//  CoreNetworking
//
//  Created by TM.Dev on 05/06/2021.
//

import Foundation

public protocol AuthenticationStoreManagable {
    var accessToken: String? { get }
    var refreshToken: String? { get }
    
    func saveStore(authenticationStorable: AuthenticationStoreable)
    func retrieveStore() -> AuthenticationStoreable
    func clearStore()
}
