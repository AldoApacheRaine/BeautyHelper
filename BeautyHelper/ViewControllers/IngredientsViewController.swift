//
//  ProductIngredientsViewController.swift
//  BeautyHelper
//
//  Created by Максим Хмелев on 28.11.2022.
//

import UIKit

class IngredientsViewController: UIViewController {
    
    lazy var ingredientsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var ingredients: [Ingredient] = []
    var product: Product?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Результат анализа"
        setupViews()
        setConstraints()
        setTableView()
    }
    
    private func setupViews() {
        view.backgroundColor = .specialBackground
        view.addSubview(ingredientsTableView)
    }
    
    private func setTableView() {
        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
        ingredientsTableView.register(IngredientTableViewCell.self)
        ingredientsTableView.registerHeader(ProductHeaderView.self)
    }
}

// MARK: - UITableViewDelegate

extension IngredientsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return product != nil ? 200 : 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard product != nil else { return nil }
        let header = tableView.dequeueReusableHeader(ProductHeaderView.self)
        header?.configureHeader(product?.name ?? "nil")
        return header
    }
}

// MARK: - UITableViewDataSource

extension IngredientsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(IngredientTableViewCell.self) {
            let ingredient = ingredients[indexPath.row]
            cell.cellConfigure(ingredient.inciName, ingredient.factor)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("нажато на ячейку - \(indexPath.row)")
//        print("Ингредиент - \(ingredients[indexPath.row])")
//        print("Описание - \(ingredients[indexPath.row].description)")
//        print("Категории - \(ingredients[indexPath.row].category)")
        print("Фактор опасности - \(ingredients[indexPath.row].factorValue) \(ingredients[indexPath.row].factor.rawValue)")



        let slideVC = IngredientDetailViewController()
        slideVC.ingredient = ingredients[indexPath.row]
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
