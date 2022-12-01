//
//  UIView + Extension.swift
//  BeautyHelper
//
//  Created by Максим Хмелев on 30.11.2022.
//

import UIKit

extension UIView {
    
    func addShadowOnView() {
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        layer.shadowOpacity = 0.7
        layer.shadowRadius = 1.0
    }
    
    func addShadowOnTextView() {
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        layer.shadowOpacity = 0.7
        layer.shadowRadius = 1.0
    }
}
