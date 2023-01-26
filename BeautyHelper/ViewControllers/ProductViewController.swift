//
//  ProductIngredientsViewController.swift
//  BeautyHelper
//
//  Created by Максим Хмелев on 28.11.2022.
//

import UIKit

class ProductViewController: UIViewController {
    
    lazy var ingredientsTableView = IngredientsTableView(frame: .zero, style: .grouped)
    
    var ingredients: [Ingredient] = []
    var product: Product?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Результат анализа"
        setupViews()
        setConstraints()
        setValues()
        setupBarButton()
        NotificationCenter.default.addObserver(self, selector: #selector(updateHeader), name: NSNotification.Name(rawValue:  "updateViews"), object: nil)
        ingredientsTableView.presentVCDelegate = self
    }
    
    private func setupViews() {
        view.backgroundColor = .specialBackground
        view.addSubview(ingredientsTableView)
    }
    
    func setValues() {
        ingredientsTableView.ingredients = ingredients
        ingredientsTableView.product = product
    }
    
    private func setupBarButton() {
        let editButton = UIBarButtonItem(image: UIImage(systemName: "pencil.circle"), style: .plain, target: self, action: #selector(editButtonTapped))
        self.navigationItem.rightBarButtonItem = editButton
    }
    
    @objc private func editButtonTapped(_ sender: UIBarButtonItem) {
        let editVC = EditProductViewController()
        editVC.product = product
        editVC.modalPresentationStyle = .custom
        editVC.transitioningDelegate = self
        self.present(editVC, animated: true, completion: nil)
    }
    
    @objc private func updateHeader() {
        ingredientsTableView.reloadData()
    }
}

// MARK: - PresentVCProtocol

extension ProductViewController: PresentVCProtocol {
    func presentVC(with ingredient: Ingredient) {
        let slideVC = IngredientDetailViewController()
        slideVC.ingredient = ingredient
        slideVC.modalPresentationStyle = .automatic
        self.present(slideVC, animated: true, completion: nil)
    }
}

// MARK: - UIViewControllerTransitioningDelegate

extension ProductViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationViewController(presentedViewController: presented, presenting: presenting)
    }
}

// MARK: - Set Constraints

extension ProductViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            ingredientsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            ingredientsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            ingredientsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            ingredientsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
