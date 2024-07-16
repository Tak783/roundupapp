//
//  UserDefaultsAuthenticationStoreTests.swift
//  CoreNetworkingTests
//
//  Created by TM.Dev on 05/06/2021.
//

import XCTest
import CoreNetworking

final class UserDefaultsAuthenticationStoreManagerTests: AuthenticationStoreManagerTest {
    let accessToken = "a1b23cd4e5"
    let refreshToken = "f1g23hi4ej"
    
    override func setUp() {
        super.setUp()
        Self.resetUserDefaults()
    }
    
    func test_accessToken_returnsAccessTokenInStorage() {
        let (sut, mockAuthenticationStore) = make_sut(withAccessToken: accessToken, refreshToken: refreshToken)
        XCTAssertEqual(sut.accessToken, nil)
        
        sut.saveStore(authenticationStorable: mockAuthenticationStore)
        XCTAssertEqual(sut.accessToken, accessToken)
    }
    
    func test_refreshToken_returnsRefreshTokenInStorage() {
        let (sut, mockAuthenticationStore) = make_sut(withAccessToken: accessToken, refreshToken: refreshToken)
        XCTAssertEqual(sut.refreshToken, nil)
        
        sut.saveStore(authenticationStorable: mockAuthenticationStore)
        XCTAssertEqual(sut.refreshToken, refreshToken)
    }
    
    func test_saveStore_savesAuthenticationStoreInStorage() {
        let (sut, mockAuthenticationStore) = make_sut(withAccessToken: accessToken, refreshToken: refreshToken)
        
        sut.saveStore(authenticationStorable: mockAuthenticationStore)
        
        let fetchedAccessToken = UserDefaults.standard.string(forKey: "accessToken")
        let fetchedRefreshToken = UserDefaults.standard.string(forKey: "refreshToken")
        XCTAssertEqual(fetchedAccessToken, accessToken)
        XCTAssertEqual(fetchedRefreshToken, refreshToken)
    }

    func test_retrieveStore_retrievesAuthenticationStoreFromStorage() {
        let (sut, mockAuthenticationStore) = make_sut(withAccessToken: accessToken, refreshToken: refreshToken)
        sut.saveStore(authenticationStorable: mockAuthenticationStore)
        
        let retrievedStore = sut.retrieveStore()
    
        XCTAssertEqual(retrievedStore.accessToken, accessToken)
        XCTAssertEqual(retrievedStore.refreshToken, refreshToken)
    }
    
    func test_clearStore_clearsAuthenticationStoreFromStorage() {
        let (sut, mockAuthenticationStore) = make_sut(withAccessToken: accessToken, refreshToken: refreshToken)
        sut.saveStore(authenticationStorable: mockAuthenticationStore)
        
        sut.clearStore()
    
        let retrievedStore = sut.retrieveStore()
        XCTAssertNil(retrievedStore.accessToken)
        XCTAssertNil(retrievedStore.refreshToken)
    }
}

// MARK: - Make SUT
extension UserDefaultsAuthenticationStoreManagerTests {
    private func make_sut(withAccessToken accessToken: String,
                          refreshToken: String,
                          file: StaticString = #file, line: UInt  = #line) -> (sut: UserDefaultsAuthenticationStoreManager, authenticationStore: AuthenticationStoreable)  {
        let sut = UserDefaultsAuthenticationStoreManager()
        trackForMemoryLeaks(sut, file: file, line: line)
        
        let mockAuthenticationStore = make_mockAuthenticationStore(withAccessToken: accessToken, refreshToken: refreshToken)
        return (sut, mockAuthenticationStore)
    }
    
    private func make_mockAuthenticationStore(withAccessToken accessToken: String,
                                              refreshToken: String,
                                              file: StaticString = #file, line: UInt  = #line) -> MockAuthenticationStore {
        let mockAuthenticationStore = MockAuthenticationStore(accessToken: accessToken, refreshToken: refreshToken)
        trackForMemoryLeaks(mockAuthenticationStore, file: file, line: line)
        return mockAuthenticationStore
    }
}
