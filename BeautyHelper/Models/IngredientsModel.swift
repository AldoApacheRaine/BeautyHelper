//
//  IngredientsModel.swift
//  BeautyHelper
//
//  Created by Максим Хмелев on 24.11.2022.
//

import Foundation
import UIKit

struct Ingredient: Codable {
    let ruName: String
    let latinName: String
    let inciName: String
    let category: [String]
    let naturality: Naturality
    let effect: [String]
    let type: [String]
    let factor: Factor
    let factorValue: String
    let description: String
    let synonym: [String]
}

enum Factor: String, Codable {
    case hight = "Высокий"
    case low = "Низкий"
    case average = "Средний"
    
    var image: UIImage {
        return value.image
    }

    var color: UIColor {
        return value.color
    }

    private var value: (image: UIImage, color: UIColor) {
        switch self {
        case .hight: return (UIImage(systemName: "xmark.circle.fill")!, UIColor.red)
        case .average: return (UIImage(systemName: "exclamationmark.circle.fill")!, UIColor.orange)
        case .low: return (UIImage(systemName: "checkmark.seal.fill")!, UIColor.systemGreen)
        }
    }
}


enum Naturality: String, Codable {
    case natural = "Натуральный"
    case synthetic = "Синтетический"
    
    var image: UIImage {
        return value.image
    }

    var color: UIColor {
        return value.color
    }

    private var value: (image: UIImage, color: UIColor) {
        switch self {
        case .natural: return (UIImage(systemName: "leaf.fill")!, UIColor.systemGreen)
        case .synthetic: return (UIImage(systemName: "testtube.2")!, UIColor.purple)
        }
    }
    
    var titleImage: UIImage {
        switch self {
        case .natural:
            return UIImage(named: "naturaly")!
        case .synthetic:
            return UIImage(named: "synthetic")!

        }
    }
}
