//
//  UITableView + Extension.swift
//  BeautyHelper
//
//  Created by Максим Хмелев on 28.11.2022.
//

import UIKit

extension UITableView {
    
    func register(_ type: UITableViewCell.Type) {
        let className = String(describing: type)
        register(type, forCellReuseIdentifier: className)
    }
    
    func dequeueReusableCell<T>(_ type: T.Type) -> T? {
        let className = String(describing: type)
        return dequeueReusableCell(withIdentifier: className) as? T
    }
    
    func registerHeader(_ type: UITableViewHeaderFooterView.Type) {
        let className = String(describing: type)
        register(type, forHeaderFooterViewReuseIdentifier: className)
    }
    
    func dequeueReusableHeader<T>(_ type: T.Type) -> T? {
        let className = String(describing: type)
        return dequeueReusableHeaderFooterView(withIdentifier: className) as? T
    }
}
