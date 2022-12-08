//
//  ProductIngredientsViewController.swift
//  BeautyHelper
//
//  Created by Максим Хмелев on 28.11.2022.
//

import UIKit

class ProductIngredientsViewController: UIViewController {
    
    private lazy var ingredientsTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var ingredients: [Ingredient] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Результат анализа"
        setupViews()
        setConstraints()
        setTableView()
//        print(ingredients)
    }
    
    private func setupViews() {
        view.backgroundColor = .specialBackground
        view.addSubview(ingredientsTableView)
    }
    
    private func setTableView() {
        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
        ingredientsTableView.register(IngredientTableViewCell.self)
    }
}

// MARK: - UITableViewDelegate

extension ProductIngredientsViewController: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource

extension ProductIngredientsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(IngredientTableViewCell.self) {
            let ingredient = ingredients[indexPath.row]
            cell.cellConfigure(ingredient.name, ingredient.effects)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("нажато на ячейку - \(indexPath.row)")
        let slideVC = IngredientDetailViewController()
        slideVC.modalPresentationStyle = .custom
        slideVC.transitioningDelegate = self
        self.present(slideVC, animated: true, completion: nil)
    }
}

// MARK: - Presentation Controller

extension ProductIngredientsViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}

// MARK: - Set Constraints

extension ProductIngredientsViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            ingredientsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            ingredientsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            ingredientsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            ingredientsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
