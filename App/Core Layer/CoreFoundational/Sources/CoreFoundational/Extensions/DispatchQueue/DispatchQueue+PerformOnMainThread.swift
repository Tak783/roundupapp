//
//  DispatchQueue+PerformOnMainThread.swift
//
//
//  Created by TM.Dev on 04/02/2024.
//

import Foundation

extension DispatchQueue {
    public static func performOnMainThread(
        action: @escaping() -> Void
    ) {
        DispatchQueue.main.async {
            action()
        }
    }
}
