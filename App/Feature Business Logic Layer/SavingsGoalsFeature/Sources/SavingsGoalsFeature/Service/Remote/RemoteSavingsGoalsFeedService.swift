//
//  RemoteSavingsGoalsFeedService.swift
//  SavingsGoalsFeature
//
//  Created by TM.Dev on 07/06/2021.
//

import CoreNetworking
import Foundation

public final class RemoteSavingsGoalsFeedService: SavingsGoalsFeedServicable {
    let client: HTTPClient

    public enum Error: Swift.Error {
        case invalidResponse
        case invalidData
    }

    public init(client: HTTPClient) {
        self.client = client
    }

    public func loadSavingsGoalsforAccount(
        withUID accountUID: String,
        completion: @escaping (SavingsGoalsResult) -> Void
    ) {
        let request = URLPool.savingsGoalFeedRequest(
            forAccountUID: accountUID
        )
        client.performRequest(request) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case let .success((data, response)):
                do {
                    if response.statusCode != 200 {
                        completion(.failure(Error.invalidResponse))
                    } else {
                        let remoteSavingsGoalFeed = try JSONDecoder().decode(
                            RemoteSavingsGoalFeed.self, 
                            from: data
                        )
                        completion(.success(
                            remoteSavingsGoalFeed.savingsGoalList.toModels()
                        ))
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

private struct RemoteSavingsGoalFeed: Codable {
    let savingsGoalList: [RemoteSavingsGoal]
}
