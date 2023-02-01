//
//  JsonLoadManager.swift
//  BeautyHelper
//
//  Created by Максим Хмелев on 31.01.2023.
//

import Foundation

class JsonLoadManager {
    
    enum CustomError: Error {
        case badURL
        case invalidData
    }
    
    static let shared = JsonLoadManager()
    
    private init() {}
    
    func loadData(completion: @escaping (Result<[Ingredient], CustomError>) -> Void) {
        guard let url = Bundle.main.url(forResource: "ingredientDBNew", withExtension: "json") else {
            completion(.failure(.badURL))
            return
        }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode([Ingredient].self, from: data)
            completion(.success(jsonData))
        } catch {
            completion(.failure(.invalidData))
        }
    }
}
