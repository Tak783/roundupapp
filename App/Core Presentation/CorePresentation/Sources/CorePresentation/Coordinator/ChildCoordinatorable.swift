//
//  ChildCoordinatorable.swift
//  
//
//  Created by TM.Dev on 28/01/2022.
//  
//

import Foundation

public protocol ChildCoordinatorable: Coordinatorable {
    var parentCoordinator: ParentCoordinatorable? { get set }
}
