//
//  UIView + Extension.swift
//  BeautyHelper
//
//  Created by Максим Хмелев on 30.11.2022.
//

import UIKit

extension UIView {
    
    func addBottomShadow() {
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        layer.shadowOpacity = 0.7
        layer.shadowRadius = 1.0
    }
    
    func addBottomAndTrailingShadow() {
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        layer.shadowOpacity = 0.7
        layer.shadowRadius = 1.0
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
        
    }
}
