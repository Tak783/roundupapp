//
//  RemoteSaveSavingsGoalService.swift
//  SavingsGoalsFeature
//
//  Created by TM.Dev on 09/06/2021.
//

import CoreNetworking
import Foundation

public final class RemoteSaveSavingsGoalService {
    let client: HTTPClient

    public enum Error: Swift.Error {
        case invalidResponse
        case invalidData
        case invalidRequest
        case failedToSave
    }

    public init(client: HTTPClient) {
        self.client = client
    }
}

// MARK: - SaveSavingsGoalServicable
extension RemoteSaveSavingsGoalService: SaveSavingsGoalServicable {
    public func saveSavingsGoalRequestForAccount(
        withUID accountUID: String,
        goalName: String,
        target: GoalTarget,
        completion: @escaping (SaveSavingsGoalsResult) -> Void
    ) {
        do {
            let request = try URLPool.saveSavingsGoalRequest(
                forAccountUID: accountUID,
                goalName: goalName,
                target: target
            )
            client.performRequest(request) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case let .success((data, response)):
                    self.handleSaveSavingsGoalSuccess(
                        data: data,
                        response: response,
                        completion: completion
                    )
                case .failure(let error):
                    completion(.failure(error))
                    break
                }
            }
        } catch {
            assertionFailure(error.localizedDescription)
            completion(.failure(Error.invalidRequest))
        }
    }
    
    private func handleSaveSavingsGoalSuccess(
        data: Data,
        response: HTTPURLResponse,
        completion: @escaping (SaveSavingsGoalsResult) -> Void
    ) {
        do {
            if response.statusCode != 200 {
                completion(.failure(Error.invalidResponse))
            } else {
                let remoteSavingsGoalFeed = try JSONDecoder().decode(
                    RemoteSavedSavingsGoal.self,
                    from: data
                )
                if remoteSavingsGoalFeed.success {
                    completion(.success(remoteSavingsGoalFeed.toModel()))
                } else {
                    completion(.failure(Error.failedToSave))
                }
            }
        } catch {
            completion(.failure(Error.invalidData))
        }
    }
}
