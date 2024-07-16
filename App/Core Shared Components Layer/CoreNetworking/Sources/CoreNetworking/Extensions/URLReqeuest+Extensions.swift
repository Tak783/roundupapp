//
//  URLRequest+Extensions.swift
//  CoreNetworking
//
//  Created by TM.Dev on 06/06/2021.
//

import Foundation
import CoreFoundational

public extension URLRequest {
    enum ContentType: String {
        case json = "application/json"
        case formURLencoded = "application/x-www-form-urlencoded"
    }
    
    mutating func updateBearerToken(
        authenticationStoreManager: AuthenticationStoreManagable = UserDefaultsAuthenticationStoreManager()
    ) {
        setValue(
            "Bearer \(authenticationStoreManager.accessToken ?? String.empty)",
            forHTTPHeaderField: "Authorization"
        )
    }
    
    mutating func setContentType(
        _ contentType: ContentType
    ) {
        setValue(contentType.rawValue, forHTTPHeaderField: "Content-Type")
    }
}
