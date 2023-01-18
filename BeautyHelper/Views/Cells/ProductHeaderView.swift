//
//  ProductHeaderView.swift
//  BeautyHelper
//
//  Created by Максим Хмелев on 17.01.2023.
//

import UIKit

class ProductHeaderView: UITableViewHeaderFooterView {
        
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "product")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var productTitleLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.text = "Продукт из бд"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super .init(reuseIdentifier: reuseIdentifier)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(productImageView)
        addSubview(productTitleLabel)
    }
    
    func configureHeader(_ productName: String, _ productImage: Data?) {
        productTitleLabel.text = productName
        if let productImage = productImage {
            productImageView.image = UIImage(data: productImage)
        }
    }
}

// MARK: - SetConstraints

extension ProductHeaderView {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: topAnchor),
            productImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            productImageView.widthAnchor.constraint(equalToConstant: 150),
            productImageView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        NSLayoutConstraint.activate([
            productTitleLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 8),
            productTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
