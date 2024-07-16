//
//  AuthenticationManagable.swift
//  CoreNetworking
//
//  Created by TM.Dev on 05/06/2021.
//

import Foundation

public protocol AuthenticationManagable {
    func refreshAccessToken(completion: @escaping (HTTPClient.Result) -> Void)
}
