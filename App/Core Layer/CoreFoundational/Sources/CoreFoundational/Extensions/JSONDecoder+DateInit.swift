//
//  JSONDecoder+DateInit.swift
//
//
//  Created by TM.Dev on 15/07/2024.
//

import Foundation

extension JSONDecoder {
    public convenience init(
        with formatter: DateFormatter
    ) {
        self.init()
        self.dateDecodingStrategy = .formatted(formatter)
    }
}
