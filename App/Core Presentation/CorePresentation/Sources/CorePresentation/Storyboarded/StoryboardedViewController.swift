//
//  StoryboardedViewController.swift
//  
//
//  Created by TM.Dev on 28/01/2022.
//  
//

import Foundation
import CoreFoundational
import UIKit

extension Storyboarded where Self: UIViewController {
    private static var storyboardName: String {
        className.deletingSuffix("ViewController")
    }

    public static func instantiate(fromBundle bundle: Bundle = Bundle.main) -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: className) as? Self else {
            fatalError("Could not create View Controller with name \(className) from storyboard \(storyboardName)")
        }
        return viewController
    }
}
