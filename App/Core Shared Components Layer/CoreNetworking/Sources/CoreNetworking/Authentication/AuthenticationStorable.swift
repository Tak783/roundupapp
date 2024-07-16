//
//  AuthenticationStorable.swift
//  CoreNetworking
//
//  Created by TM.Dev on 05/06/2021.
//

import Foundation

public protocol AuthenticationStoreable {
    var accessToken: String? { get }
    var refreshToken: String? { get }
}
