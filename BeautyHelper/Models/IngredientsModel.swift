//
//  IngredientsModel.swift
//  BeautyHelper
//
//  Created by Максим Хмелев on 24.11.2022.
//

import Foundation

struct Ingredient: Codable {
    let name: String
    let type: String
    let effects: Effects
    let discription: String
}
enum Effects: String, Codable {
    case average = "Average"
    case best = "Best"
    case good = "Good"
    case poor = "Poor"
    
    var value: String {
        switch self {
        case .average:
            return "Удовлетворительно"
        case .best:
            return "Отлично"
        case .good:
            return "Хорошо"
        case .poor:
            return "Плохо"
        }
    }
}
/*
Preservatives
 Emollients
 Skin-Soothing
 Plant Extracts
 Fragrance: Synthetic and Fragrant Plant Extracts
 Texture Enhancer
 Antioxidants
 Sensitizing
 Skin-Replenishing
 Hydration
 Skin-Restoring
 Film-Forming/Holding Agents
 Miscellaneous
 Cleansing Agents
 Silicones
 Exfoliant
 Uncategorized
 Vitamins
 Scrub Agents
 Absorbent
 Coloring Agents/Pigments
 Sunscreen Actives
 Thickeners/Emulsifiers
 Preservatives
 Anti-Acne
 Skin-Softening
 Film-Forming Agents
 Emulsifiers
 Slip Agents
 Thickeners
*/
