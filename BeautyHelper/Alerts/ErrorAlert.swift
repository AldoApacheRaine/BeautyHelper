//
//  ErrorAlert.swift
//  BeautyHelper
//
//  Created by Максим Хмелев on 01.02.2023.
//

import UIKit

extension UIViewController {
    
    func alertError(title: String, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "ОК", style: .default)
        alertController.addAction(ok)
        present(alertController, animated: true, completion: nil)
    }
}
