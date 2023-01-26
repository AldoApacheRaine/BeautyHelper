//
//  IngredientsViewController.swift
//  BeautyHelper
//
//  Created by Максим Хмелев on 26.01.2023.
//

import UIKit

class IngredientsViewController: UIViewController {
    
    lazy var ingredientsTableView = IngredientsTableView()
    
    var ingredients: [Ingredient] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Результат анализа"
        setupViews()
        setConstraints()
        setValues()
        ingredientsTableView.presentVCDelegate = self
    }
    
    private func setupViews() {
        view.backgroundColor = .specialBackground
        view.addSubview(ingredientsTableView)
    }
    
    func setValues() {
        ingredientsTableView.ingredients = ingredients
    }
}

// MARK: - PresentVCProtocol

extension IngredientsViewController: PresentVCProtocol {
    func presentVC(with ingredient: Ingredient) {
        let slideVC = IngredientDetailViewController()
        slideVC.ingredient = ingredient
        slideVC.modalPresentationStyle = .automatic
        self.present(slideVC, animated: true, completion: nil)
    }
}

// MARK: - Set Constraints

extension IngredientsViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            ingredientsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            ingredientsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            ingredientsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            ingredientsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
