//
//  Buttons.swift
//  BeautyHelper
//
//  Created by Максим Хмелев on 01.12.2022.
//

import UIKit

class CustomButton: UIButton {
    convenience init(title: String, target: Any?, action: Selector, type: UIButton.ButtonType = .system) {
        self.init(type: type)
        backgroundColor = .specialButton
        addBottomShadow()
        tintColor = .white
        layer.cornerRadius = 10
        setTitle(title, for: .normal)
        titleLabel?.textAlignment = .center
        addTarget(target, action: action, for: .touchUpInside)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
#warning("Переделать кнопку")

class EditButton: UIButton {
    convenience init(target: Any?, action: Selector, type: UIButton.ButtonType = .custom) {
        self.init(type: type)
        setImage(UIImage(named: "saveIcon"), for: .normal)
        imageView?.contentMode = .scaleAspectFill
        addTarget(target, action: action, for: .touchUpInside)
        translatesAutoresizingMaskIntoConstraints = false
    }
}

