//
//  UIView+Extension.swift
//  swift-tip-calculator
//
//  Created by Han-Saem Park on 2024-05-03.
//

import UIKit

extension UIView {
    
    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity:Float) {
        layer.cornerRadius = radius
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor = backgroundCGColor
    }
    
    func addRoundedCorners(radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = false
    }
    
    func addRoundedCorners(corners: CACornerMask, radius: CGFloat) {
        layer.cornerRadius = radius
        layer.maskedCorners = [corners]
    }
}
