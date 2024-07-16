//
//  URLPool.swift
//  SavingsGoalsFeature
//
//  Created by TM.Dev on 07/06/2021.
//

import CoreFoundational
import CoreNetworking
import Foundation

// MARK: - URL Components
extension URLPool: SavingsAPIURLPoolable {
    private static let scheme = "https"
    private static let host = "api-sandbox.starlingbank.com"
    private static let path = "/api/v2/"
    
    private enum EndPoints: String {
        case account = "account"
        case savingsGoals = "savings-goals"
        case addMoney = "add-money"
    }
}

// MARK: - Savings Goal Feed Request Request
extension URLPool {
    static func savingsGoalFeedRequest(
        forAccountUID accountUID: String
    ) -> URLRequest {
        let endPoint = path + EndPoints.account.rawValue + "/\(accountUID)/" + EndPoints.savingsGoals.rawValue
        let url = configureURL(scheme: scheme, host: host, path: endPoint)
        var request = URLRequest.init(method: .get, url: url)
        request.updateBearerToken()
        return request
    }
}

// MARK: - Save Savings Goal Request
extension URLPool {
    static func saveSavingsGoalRequest(
        forAccountUID accountUID: String,
        goalName: String,
        target: GoalTarget
    ) throws -> URLRequest {
        let savingsGoal = SaveableSavingsGoal(
            name: goalName,
            currency: target.currency,
            target: RemoteGoalTarget(
                currency: target.currency,
                minorUnits: target.minorUnits
            ),
            base64EncodedPhoto: nil
        )        
        let endPoint = path + EndPoints.account.rawValue + "/\(accountUID)/" + EndPoints.savingsGoals.rawValue
        let url = configureURL(scheme: scheme, host: host, path: endPoint)
        let data = try JSONEncoder().encode(savingsGoal)
        var request = URLRequest.init(method: .put, url: url)
        request.httpBody = data
        request.updateBearerToken()
        request.setContentType(.json)
        return request
    }
    
    private struct SaveableSavingsGoal: Encodable {
        let name: String
        let currency: String
        let target: RemoteGoalTarget
        let base64EncodedPhoto: String?
    }
}
 
// MARK: - Add To Savings Goal Request
extension URLPool {
    static func add(
        amount: RemoteTotalSaved,
        forAccountUID accountUID: String,
        intoSavingsGoalUid savingsGoalUid: String,
        transferGoalsUUID: String
    ) throws -> URLRequest {
        let endPointPrefix = path + EndPoints.account.rawValue + "/\(accountUID)/"
        let endPointSuffix = EndPoints.savingsGoals.rawValue + "/\(savingsGoalUid)/" + EndPoints.addMoney.rawValue + "/\(transferGoalsUUID)"
        let endPoint = endPointPrefix + endPointSuffix
        let remoteTotalToSave = RemoteTotalToSave(amount: amount)
        
        let url = configureURL(scheme: scheme, host: host, path: endPoint)
        let data = try JSONEncoder().encode(remoteTotalToSave)
        var request = URLRequest.init(method: .put, url: url)
        request.httpBody = data
        request.updateBearerToken()
        request.setContentType(.json)
        return request
    }
    
    private struct RemoteTotalToSave: Codable {
        let amount: RemoteTotalSaved
    }
}
