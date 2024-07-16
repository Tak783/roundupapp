//
//  RemoteAccountsFeedService.swift
//  AccountsFeature
//
//  Created by TM.Dev on 06/06/2021.
//

import CoreNetworking
import CoreFoundational
import Foundation

public final class RemoteAccountsFeedService: AccountsFeedServiceable {
    let client: HTTPClient

    public enum Error: Swift.Error {
        case invalidResponse
        case invalidData
    }

    public init(client: HTTPClient) {
        self.client = client
    }

    public func load(completion: @escaping (AccountResult) -> Void) {
        let request = URLPool.accountsRequest()
        client.performRequest(request) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case let .success((data, response)):
                do {
                    if response.statusCode != 200 {
                        completion(.failure(Error.invalidResponse))
                    } else {
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .formatted(
                            .jsonDateTimeFormatter
                        )
                        
                        let account = try decoder.decode(
                            RemoteAccountFeed.self,
                            from: data
                        )
                        completion(
                            .success(account.accounts.toModels())
                        )
                    }
                } catch {
                    completion(.failure(Error.invalidData))
                }
            case .failure(let error):
                completion(.failure(error))
                break
            }
        }
    }
}

private struct RemoteAccountFeed: Codable {
    let accounts: [RemoteAccount]
}
