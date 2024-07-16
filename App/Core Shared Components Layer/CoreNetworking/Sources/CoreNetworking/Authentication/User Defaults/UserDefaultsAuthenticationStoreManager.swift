//
//  UserDefaultsAuthenticationStoreManager.swift
//  CoreNetworking
//
//  Created by TM.Dev on 05/06/2021.
//

import Foundation

public final class UserDefaultsAuthenticationStoreManager: AuthenticationStoreManagable {
    public var accessToken: String? {
        return retrieveStore().accessToken
    }
    public var refreshToken: String? {
        return retrieveStore().refreshToken
    }
    private let userDefaults = UserDefaults.standard
    private enum StoreManagerKeys: String {
        case accessToken
        case refreshToken
    }
    
    public init() {}
    
    public func saveStore(authenticationStorable: AuthenticationStoreable) {
        userDefaults.set(authenticationStorable.accessToken, forKey: StoreManagerKeys.accessToken.rawValue)
        userDefaults.set(authenticationStorable.refreshToken, forKey: StoreManagerKeys.refreshToken.rawValue)
    }
    
    public func retrieveStore() -> AuthenticationStoreable {
        let accessToken = userDefaults.string(forKey: StoreManagerKeys.accessToken.rawValue)
        let refreshToken = userDefaults.string(forKey: StoreManagerKeys.refreshToken.rawValue)
        return UserDefaultsAuthenticationStore.init(accessToken: accessToken, refreshToken: refreshToken)
    }
    
    public func clearStore() {
        userDefaults.removeObject(forKey: StoreManagerKeys.accessToken.rawValue)
        userDefaults.removeObject(forKey: StoreManagerKeys.refreshToken.rawValue)
    }
}
