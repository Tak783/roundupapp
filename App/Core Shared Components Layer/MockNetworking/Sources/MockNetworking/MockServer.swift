//
//  MockServer.swift
//  MockNetworking
//
//  Created by TM.Dev on 14/04/2021.
//

import Foundation

public final class MockServer {
    public static func loadLocalJSON(
        _ fileName: String,
        fromBundle bundle: Bundle
    ) -> Data {
        guard let filePath = bundle.path(forResource: fileName, ofType: "json") else {
            fatalError("Mock data was not present in bundle")
        }
        do {
            let fileURL = URL(fileURLWithPath: filePath)
            let data = try Data(contentsOf: fileURL, options: .mappedIfSafe)
            return data
        } catch {
            fatalError("Failed to open mock data file in bundle ")
        }
    }
}

/*
 {
     guard let fileURL = bundle.url(
         forResource: fileName,
         withExtension: "json",
         subdirectory: "Resources"
     ) else {
         fatalError("Failed to open mock data file in bundle ")
     }
     do {
         //return try? Data(contentsOf: url)
         let data = try Data(contentsOf: fileURL, options: .mappedIfSafe)
         return data
     } catch {
         fatalError("Failed to open mock data file in bundle ")
     }
 }
 */
