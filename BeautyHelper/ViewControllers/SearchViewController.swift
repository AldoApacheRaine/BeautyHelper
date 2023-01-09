//
//  SearchViewController.swift
//  BeautyHelper
//
//  Created by Максим Хмелев on 21.11.2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    var ingredients: [Ingredient] = []
    private var filteredIngredients: [Ingredient] = []
    
    lazy var searchController = UISearchController(searchResultsController: IngredientsViewController())

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Поиск ингредиента"
        searchController.searchBar.placeholder = "Введите название ингредиента"
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        view.backgroundColor = .specialBackground
    }
}

// MARK: - UISearchResultsUpdating
extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        guard let ingredientsVC = searchController.searchResultsController as? IngredientsViewController else { return }
        filteredIngredients.removeAll()
        
        for item in ingredients {
            let text = text.lowercased()
            let isArrayContain = item.inciName.lowercased().range(of: text)
            
            if isArrayContain != nil {
                filteredIngredients.append(item)
            }
        }
        
        ingredientsVC.ingredients = filteredIngredients
        ingredientsVC.ingredientsTableView.reloadData()
        ingredientsVC.ingredientsTableView.keyboardDismissMode = .onDrag
    }
}
