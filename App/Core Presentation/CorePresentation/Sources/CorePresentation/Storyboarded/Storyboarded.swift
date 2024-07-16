//
//  Storyboarded.swift
//  
//
//  Created by TM.Dev on 28/01/2022.
//  
//

import Foundation

public protocol Storyboarded {
    static func instantiate(fromBundle bundle: Bundle) -> Self
}
