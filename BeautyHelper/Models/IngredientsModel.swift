//
//  IngredientsModel.swift
//  BeautyHelper
//
//  Created by Максим Хмелев on 24.11.2022.
//

import Foundation

struct Ingredient: Codable {
    let name: String
    let effect: [Effect]
    let type: TypeEnum
    let description: String?
}
enum TypeEnum: String, Codable {
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

enum Effect: String, Codable {
    case absorbent = "Absorbent"
    case antiAcne = "Anti-Acne"
    case antioxidants = "Antioxidants"
    case cleansingAgents = "Cleansing Agents"
    case coloringAgentsPigments = "Coloring Agents/Pigments"
    case emollients = "Emollients"
    case emulsifiers = "Emulsifiers"
    case exfoliant = "Exfoliant"
    case filmFormingAgents = "Film-Forming Agents"
    case filmFormingHoldingAgents = "Film-Forming/Holding Agents"
    case fragranceSyntheticAndFragrantPlantExtract = "Fragrance: Synthetic and Fragrant Plant Extract"
    case hydration = "Hydration"
    case miscellaneous = "Miscellaneous"
    case plantExtracts = "Plant Extracts"
    case preservatives = "Preservatives"
    case scrubAgents = "Scrub Agents"
    case sensitizing = "Sensitizing"
    case silicones = "Silicones"
    case skinReplenishing = "Skin-Replenishing"
    case skinRestoring = "Skin-Restoring"
    case skinSoftening = "Skin-Softening"
    case skinSoothing = "Skin-Soothing"
    case slipAgents = "Slip Agents"
    case sunscreenActives = "Sunscreen Actives"
    case textureEnhancer = "Texture Enhancer"
    case thickeners = "Thickeners"
    case thickenersEmulsifiers = "Thickeners/Emulsifiers"
    case uncategorized = "Uncategorized"
    case vitamins = "Vitamins"
    
    var value: String {
        switch self {
            
        case .absorbent:
            return "Абсорбент"
        case .antiAcne:
            return "Анти-акне"
        case .antioxidants:
            return "Антиоксидант"
        case .cleansingAgents:
            return "Очищающий агент"
        case .coloringAgentsPigments:
            return "Краситель/пигмент"
        case .emollients:
            return "Смягчающее средство"
        case .emulsifiers:
            return "Эмульгатор"
        case .exfoliant:
            return "Эксфолиант"
        case .filmFormingAgents:
            return "Пленкообразующий агент"
        case .filmFormingHoldingAgents:
            return "Пленкообразующий/удерживающий агент"
        case .fragranceSyntheticAndFragrantPlantExtract:
            return "Аромат: синтетический и ароматный растительный экстракт"
        case .hydration:
            return "Увлажнение"
        case .miscellaneous:
            return "Разнообразный"
        case .plantExtracts:
            return "Экстракт растений"
        case .preservatives:
            return "Консервант"
        case .scrubAgents:
            return "Скрабирующий агент"
        case .sensitizing:
            return "Повышение чувствительности"
        case .silicones:
            return "Силикон"
        case .skinReplenishing:
            return "Восстановление кожи"
        case .skinRestoring:
            return "«Восстановление кожи»"
        case .skinSoftening:
            return "Смягчение кожи"
        case .skinSoothing:
            return "Успокаивающий кожу"
        case .slipAgents:
            return "Скольжение"
        case .sunscreenActives:
            return "Солнцезащитное действие"
        case .textureEnhancer:
            return "Улучшение текстуры"
        case .thickeners:
            return "Загуститель"
        case .thickenersEmulsifiers:
            return "«Загуститель/эмульгатор"
        case .uncategorized:
            return "Без категории"
        case .vitamins:
            return "Витамины"
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
 
 «Абсорбент»
 "Анти-акне"
 «Антиоксиданты»
 «Очищающие агенты»
 «Красители/пигменты»
 «Смягчающие средства»
 «Эмульгаторы»
 «Эксфолиант»
 «Пленкообразующие агенты»
 «Пленкообразующие/удерживающие агенты»
 «Аромат: синтетический и ароматный растительный экстракт»
 «Увлажнение»
 "Разнообразный"
 «Экстракты растений»
 «Консерванты»
 «Агенты скраба»
 «сенсибилизирующий»
 "Силиконы"
 «Восстановление кожи»
 «Восстановление кожи»
 «Смягчение кожи»
 "Успокаивающий кожу"
 "Скользящие агенты"
 «Солнцезащитные активы»
 «Улучшитель текстур»
 «Загустители»
 «Загустители/эмульгаторы»
 "Без категории"
 "Витамины"
*/
