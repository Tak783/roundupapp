//
//  NibView.swift
//  
//
//  Created by TM.Dev on 17/04/2021.
//

import Foundation
import UIKit

@IBDesignable
open class NibView: UIView {

    var forcedNibName: String?
    var view: UIView?

    public init(frame: CGRect, forcedNibName: String? = nil) {
        self.forcedNibName = forcedNibName
        super.init(frame: frame)
        setup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    func setup() {
        if let forcedNibName = forcedNibName {
            setupNib(forcedNibName)
        } else if let nibName = classForCoder.description().components(separatedBy: ".").last {
            setupNib(String(nibName))
        }
    }

    func setupNib(_ nibName: String) {
        if let view = loadViewFromNib(nibName) {
            self.view = view
            self.view?.frame = bounds
            self.view?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            addSubview(view)
        }
    }

    func loadViewFromNib(_ nibName: String) -> UIView? {
        let bundle = Bundle(for: Self.self)
        if bundle.path(forResource: nibName, ofType: "nib") != nil {
            let nib = UINib(nibName: nibName, bundle: bundle)
            if let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView {
                return view
            }
        }
        return nil
    }
}
