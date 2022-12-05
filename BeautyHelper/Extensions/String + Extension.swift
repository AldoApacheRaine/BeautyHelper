//
//  String + Extension.swift
//  BeautyHelper
//
//  Created by Максим Хмелев on 29.11.2022.
//

import Foundation


extension String {
    
    func stringToComponents() -> [String] {
        var components: [String] = []
        if let index = self.lastIndex(of: ":") {
            var croppedText = self.suffix(from: index)
            croppedText.removeFirst()
            let finalText = croppedText.replacingOccurrences(of: ".", with: ",").uppercased()
            let componentsArray = finalText.components(separatedBy: ",").map{ $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            components = componentsArray
        } else {
            let finalText = self.replacingOccurrences(of: ".", with: ",").uppercased()
            let componentsArray = finalText.components(separatedBy: ",").map{ $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            components = componentsArray
        }
        return components
    }
}
