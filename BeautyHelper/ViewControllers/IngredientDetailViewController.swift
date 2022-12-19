//
//  IngredientDetailViewController.swift
//  BeautyHelper
//
//  Created by Максим Хмелев on 08.12.2022.
//

import UIKit

class IngredientDetailViewController: UIViewController {
    
    var ingredient: Ingredient?
    
    //
    //    private lazy var scrollView: UIScrollView = {
    //        let scroll = UIScrollView()
    //        scroll.contentInsetAdjustmentBehavior = .never
    //        scroll.frame = self.view.bounds
    //        scroll.contentSize = contentSize
    //        return scroll
    //    }()
    
    //    private lazy var contentView: UIView = {
    //        let contentView = UIView()
    //        contentView.backgroundColor = .clear
    //        contentView.frame.size = contentSize
    //        return contentView
    //    }()
    //
    //    private var contentSize: CGSize {
    //        CGSize(width: view.frame.width, height: view.frame.height + 1)
    //    }
    
    private lazy var effectsCollectionView = EffectsCollectionView()
    
    private lazy var slideIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var ingredientImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "chemical")
        imageView.contentMode = .scaleAspectFill
        imageView.addShadowOnView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        setDetails()
    }
    
    private func setupViews() {
        view.backgroundColor = .specialBackground
        view.addSubview(slideIndicator)
        view.addSubview(ingredientImageView)
        view.addSubview(nameLabel)
        view.addSubview(effectsCollectionView)
        view.addSubview(typeLabel)
        view.addSubview(descriptionLabel)
        //        view.addSubview(scrollView)
        //        scrollView.addSubview(contentView)
        //        contentView.addSubview(ingredientImageView)
    }
    
    private func setDetails() {
        effectsCollectionView.ingredient = ingredient
        nameLabel.text = ingredient?.inciName.uppercased()
        typeLabel.text = ingredient?.factor.rawValue
        if ingredient?.description == nil {
            descriptionLabel.text = "Нет описания."
        } else {
            descriptionLabel.text = ingredient?.description
        }
    }
}

// MARK: - Set constraints

extension IngredientDetailViewController {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            slideIndicator.topAnchor.constraint(equalTo: view.topAnchor, constant: 12),
            slideIndicator.heightAnchor.constraint(equalToConstant: 4),
            slideIndicator.widthAnchor.constraint(equalToConstant: 100),
            slideIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            ingredientImageView.topAnchor.constraint(equalTo: slideIndicator.bottomAnchor, constant: 24),
            ingredientImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ingredientImageView.heightAnchor.constraint(equalToConstant: 150),
            ingredientImageView.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: ingredientImageView.bottomAnchor, constant: 8),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            effectsCollectionView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
            effectsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            effectsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            effectsCollectionView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalTo: effectsCollectionView.bottomAnchor, constant: 16),
            typeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
}
