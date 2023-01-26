//
//  IngredientsTableView.swift
//  BeautyHelper
//
//  Created by Максим Хмелев on 26.01.2023.
//

import UIKit

protocol PresentVCProtocol: AnyObject {
    func presentVC(with ingredient: Ingredient)
}

class IngredientsTableView: UITableView {
    
    var ingredients = [Ingredient]()
    var product: Product?
    weak var presentVCDelegate: PresentVCProtocol?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        separatorStyle = .none
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        
        delegate = self
        dataSource = self
        
        registerHeader(ProductHeaderView.self)
        register(IngredientTableViewCell.self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UITableViewDelegate

extension IngredientsTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return product != nil ? UITableView.automaticDimension : 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard product != nil else { return nil }
        let header = tableView.dequeueReusableHeader(ProductHeaderView.self)
        header?.configureHeader(product?.name ?? "nil", product?.image)
        return header
    }
}

// MARK: - UITableViewDataSource

extension IngredientsTableView: UITableViewDataSource {
    
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
        let ingredient = ingredients[indexPath.row]
        presentVCDelegate?.presentVC(with: ingredient)
    }
}



