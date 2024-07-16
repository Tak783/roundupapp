//
//  AccountsFeedServiceable.swift
//  AccountsFeature
//
//  Created by TM.Dev on 06/06/2021.
//

public protocol AccountsFeedServiceable: AnyObject  {
    typealias AccountResult = Swift.Result<[Account], Error>

    func load(completion: @escaping (AccountResult) -> Void)
}
