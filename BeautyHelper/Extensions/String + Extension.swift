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
        let preparedString = prepareString(from: self)
        if let range = preparedString.uppercased().range(of: "AQUA") {
            let suffix = preparedString.suffix(from: range.lowerBound)
            components = fromStringToArray(from: String(suffix))
        } else if let range = preparedString.range(of: ":") {
            var suffix = preparedString.suffix(from: range.lowerBound)
            suffix.removeFirst()
            components = fromStringToArray(from: String(suffix))
        } else {
            components = fromStringToArray(from: preparedString)
        }
        print(components)
        return components
    }
    
    private func prepareString(from text: String) -> String {
        let pattern = "\\([^\\(]*[А-Яа-я][^\\)]*\\)"
        let string = text.replacingOccurrences(of: pattern, with: "", options: .regularExpression)
        let pattern2 = "[&\\*\\$%#@•]"
        let cleanedString = string.replacingOccurrences(of: pattern2, with: "", options: .regularExpression)
        return cleanedString
    }
    
    private func fromStringToArray(from text: String) -> [String] {
        let finalText = text.replacingOccurrences(of: ".", with: ",").uppercased()
        let components = finalText.components(separatedBy: ", ").map{ $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        return components
    }
}
