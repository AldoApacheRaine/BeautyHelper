//
//  HistoryViewController.swift
//  BeautyHelper
//
//  Created by Максим Хмелев on 21.11.2022.
//

import UIKit

class HistoryViewController: UIViewController {

    lazy var historyTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var products: [Product] = []
    var ingredients: [Ingredient] = []

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.title = "История"
        setupViews()
        setConstraints()
        setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        products = CoreDataManager.shared.getSavedProducts()
        historyTableView.reloadData()
    }

    
    private func setupViews() {
        view.backgroundColor = .specialBackground
        view.addSubview(historyTableView)
    }
    
    private func setTableView() {
        historyTableView.delegate = self
        historyTableView.dataSource = self
        historyTableView.register(HistoryTableViewCell.self)
    }
}

// MARK: - UITableViewDelegate

extension HistoryViewController: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource

extension HistoryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(HistoryTableViewCell.self) {
            let product = products[indexPath.row]
            cell.cellConfigure(product.name ?? "Default", product.date ?? Date())
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var filterIngredients: [Ingredient] = []
        let product = products[indexPath.row]
        
        for i in product.ingredients ?? [] {
            filterIngredients.append(contentsOf: ingredients.filter { $0.inciName.uppercased() == i.uppercased() })
        }
        
        let ingredientsVC = IngredientsViewController()
        ingredientsVC.ingredients = filterIngredients
        navigationController?.pushViewController(ingredientsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let product = products[indexPath.row]
        if editingStyle == .delete {
            CoreDataManager.shared.delete(product)
            products.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}

// MARK: - Set Constraints

extension HistoryViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            historyTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            historyTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            historyTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            historyTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
