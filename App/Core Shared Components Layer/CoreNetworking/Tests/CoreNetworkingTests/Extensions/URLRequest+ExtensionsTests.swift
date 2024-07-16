//
//  URLRequest+ExtensionsTests.swift
//  CoreNetworkingTests
//
//  Created by TM.Dev on 06/06/2021.
//

import XCTest
import CoreFoundational
import CoreNetworking

final class URLRequest_ExtensionsTests: XCTestCase {
    override func setUp() {
        super.setUp()
        Self.resetUserDefaults()
    }
    
    func test_updateBearerToken_addsBearerToken() {
        var sut = make_sut()
        sut.updateBearerToken()
        XCTAssertEqual(sut.value(forHTTPHeaderField: "Authorization"), "Bearer \(String.empty)")
        
        let accessToken = "a1b23cd4e5"
        let mockAuthenticationStore = MockAuthenticationStore(accessToken: accessToken, refreshToken: "f1g23hi4ej")
        let userDefaultsAuthenticationStoreManager = UserDefaultsAuthenticationStoreManager()
        userDefaultsAuthenticationStoreManager.saveStore(authenticationStorable: mockAuthenticationStore)
        
        sut.updateBearerToken(authenticationStoreManager: userDefaultsAuthenticationStoreManager)
        XCTAssertEqual(sut.value(forHTTPHeaderField: "Authorization"), "Bearer \(accessToken)")
    }
    
    func test_setContentType_addsCorrectContentType() {
        var sut = make_sut()
        sut.setContentType(.json)
        XCTAssertEqual(sut.value(forHTTPHeaderField: "Content-Type"), "application/json")
        
        sut.setContentType(.formURLencoded)
        XCTAssertEqual(sut.value(forHTTPHeaderField: "Content-Type"), "application/x-www-form-urlencoded")
    }
    
    func make_sut() -> URLRequest {
        let urlString = "https://raw.githubusercontent.com/"
        let url = URL(string: urlString)!
        return URLRequest(method: .get, url: url)
    }
}
