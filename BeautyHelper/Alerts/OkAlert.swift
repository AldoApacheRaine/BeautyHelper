//
//  OkAlert.swift
//  BeautyHelper
//
//  Created by Максим Хмелев on 23.01.2023.
//

import UIKit

extension UIViewController {
    
    func alertOk(title: String, message: String?, completionHandler: @escaping() -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ок", style: .default) {_ in
            completionHandler()
        }
        alertController.addAction(ok)
        present(alertController, animated: true, completion: nil)
    }
}
