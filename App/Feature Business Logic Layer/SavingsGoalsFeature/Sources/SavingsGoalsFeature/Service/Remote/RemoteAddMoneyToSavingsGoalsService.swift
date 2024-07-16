//
//  RemoteAddMoneyToSavingsGoalsService.swift
//  SavingsGoalsFeature
//
//  Created by TM.Dev on 09/06/2021.
//

import CoreNetworking
import CoreStarlingEngineSharedModels
import Foundation

public final class RemoteAddMoneyToSavingsGoalsService: AddMoneyToSavingsGoalsServicable {
    let client: HTTPClient
    let accountUID: String
    let currency: String

    public enum Error: Swift.Error {
        case invalidResponse
        case invalidData
        case failedToSave
    }

    public init(
        client: HTTPClient,
        forAccountUID accountUID: String,
        currency: String
    ) {
        self.client = client
        self.accountUID = accountUID
        self.currency = currency
    }

    public func add(
        amount: Double,
        intoSavingsGoalUid savingsGoalUid: String,
        completion: @escaping (AddMoneyToSavingsResult) -> Void
    ) {
        let amountToSave = RemoteTotalSaved(
            currency: currency,
            minorUnits: amount.minorUnit)
        do {
            let request = try URLPool.add(
                amount: amountToSave,
                forAccountUID: accountUID,
                intoSavingsGoalUid: savingsGoalUid,
                transferGoalsUUID: UUID().uuidString
            )
            client.performRequest(request) { [weak self] result in
                guard self != nil else { return }
                switch result {
                case let .success((data, response)):
                    do {
                        if response.statusCode != 200 {
                            completion(.failure(Error.invalidResponse))
                        } else {
                            let remoteTotalSavedResult = try JSONDecoder().decode(
                                RemoteSavingsGoalAddedTo.self,
                                from: data
                            )
                            if remoteTotalSavedResult.success {
                                completion(.success(remoteTotalSavedResult.toModel()))
                            } else {
                                completion(.failure(Error.failedToSave))
                            }
                        }
                    } catch {
                        completion(.failure(Error.invalidData))
                    }
                case .failure(let error):
                    completion(.failure(error))
                    break
                }
            }
        } catch {
            assertionFailure(error.localizedDescription)
        }
    }
}
