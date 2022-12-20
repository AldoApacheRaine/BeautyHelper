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
    
    private lazy var ruNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .SpecialDescription
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var factorTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.text = "Фактор опасности:"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var factorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var factorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var naturalityTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.text = "Натуральность:"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var naturalityImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var naturalityLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .SpecialDescription
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var namesStackView = UIStackView()
    private lazy var factorStackView = UIStackView()
    private lazy var factorTitleStackView = UIStackView()
    private lazy var naturalityStackView = UIStackView()
    private lazy var naturalityTitleStackView = UIStackView()
    private lazy var factorsBlockStackView = UIStackView()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStackViews()
        setupViews()
        setConstraints()
        setDetails()
        
    }
    
    private func setupViews() {
        view.backgroundColor = .specialBackground
        view.addSubview(slideIndicator)
        view.addSubview(ingredientImageView)
        view.addSubview(namesStackView)
        view.addSubview(effectsCollectionView)
        view.addSubview(factorsBlockStackView)
        view.addSubview(descriptionLabel)
        //        view.addSubview(scrollView)
        //        scrollView.addSubview(contentView)
        //        contentView.addSubview(ingredientImageView)
    }
    
    private func setDetails() {
        guard let ingredient = ingredient else { return }
        
        ingredientImageView.image = ingredient.naturality.titleImage
        effectsCollectionView.ingredient = ingredient
        nameLabel.text = ingredient.inciName.uppercased()
        ruNameLabel.text = "(\(ingredient.ruName))"
        factorImageView.image = ingredient.factor.image
        factorImageView.tintColor = ingredient.factor.color
        factorLabel.text = "\(ingredient.factor.rawValue) (\(ingredient.factorValue))"
        naturalityImageView.image = ingredient.naturality.image
        naturalityImageView.tintColor = ingredient.naturality.color
        naturalityLabel.text = ingredient.naturality.rawValue
        if ingredient.description == "" {
            descriptionLabel.text = "Нет описания."
        } else {
            descriptionLabel.text = ingredient.description
        }
    }
    
    private func setupStackViews() {
        namesStackView = UIStackView(arrangedSubviews: [nameLabel, ruNameLabel], axis: .vertical, aligment: .center, distribution: .equalSpacing, spacing: 4)
        
        factorStackView = UIStackView(arrangedSubviews: [factorImageView, factorLabel], axis: .horizontal, aligment: .center, distribution: .equalSpacing, spacing: 8)
        factorTitleStackView = UIStackView(arrangedSubviews: [factorTitleLabel, factorStackView], axis: .vertical, aligment: .leading, distribution: .equalSpacing, spacing: 4)
        
        naturalityStackView = UIStackView(arrangedSubviews: [naturalityImageView, naturalityLabel], axis: .horizontal, aligment: .center, distribution: .equalSpacing, spacing: 8)
        naturalityTitleStackView = UIStackView(arrangedSubviews: [naturalityTitleLabel, naturalityStackView], axis: .vertical, aligment: .trailing, distribution: .equalSpacing, spacing: 4)
        
        factorsBlockStackView = UIStackView(arrangedSubviews: [factorTitleStackView, naturalityTitleStackView], axis: .horizontal, aligment: .center, distribution: .equalSpacing, spacing: 16)
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
            namesStackView.topAnchor.constraint(equalTo: ingredientImageView.bottomAnchor, constant: 8),
            namesStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            namesStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
        ])
        
        NSLayoutConstraint.activate([
            effectsCollectionView.topAnchor.constraint(equalTo: namesStackView.bottomAnchor, constant: 16),
            effectsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            effectsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            effectsCollectionView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            factorImageView.widthAnchor.constraint(equalToConstant: 25),
            factorImageView.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        NSLayoutConstraint.activate([
            naturalityImageView.widthAnchor.constraint(equalToConstant: 25),
            naturalityImageView.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        NSLayoutConstraint.activate([
            factorsBlockStackView.topAnchor.constraint(equalTo: effectsCollectionView.bottomAnchor, constant: 16),
            factorsBlockStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            factorsBlockStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: factorsBlockStackView.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
}
