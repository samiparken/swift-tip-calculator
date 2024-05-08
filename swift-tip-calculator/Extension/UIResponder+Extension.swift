//
//  UIResponder+Extension.swift
//  swift-tip-calculator
//
//  Created by Han-Saem Park on 2024-05-08.
//

import UIKit

extension UIResponder {
    var parentViewController: UIViewController? {
        return next as? UIViewController ?? next?.parentViewController
    }
}
