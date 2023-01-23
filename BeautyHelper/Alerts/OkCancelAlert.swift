//
//  OkCancelAlert.swift
//  BeautyHelper
//
//  Created by Максим Хмелев on 23.01.2023.
//

import UIKit

extension UIViewController {
    
    func alertOkCancel(title: String, message: String?, completionHandler: @escaping() -> Void) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Ок", style: .default)
        
        let cancel = UIAlertAction(title: "Отменить", style: .cancel) { _ in
            completionHandler()
        }
        
        alertController.addAction(ok)
        alertController.addAction(cancel)
        
        present(alertController, animated: true, completion: nil)
    }
}
