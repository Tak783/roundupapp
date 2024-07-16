//
//  EfficientPrint.swift
//  
//
//  Created by TM.Dev on 19/03/2023.
//

import Foundation

public func efficientPrint(_ anything: Any) {
    #if DEBUG
        print(anything)
    #endif
}

public func efficientPrint(_ anything: Any...) {
    #if DEBUG
        print(anything)
    #endif
}
