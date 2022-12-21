//
//  IngredientTableViewCell.swift
//  BeautyHelper
//
//  Created by Максим Хмелев on 28.11.2022.
//

import UIKit

class IngredientTableViewCell: UITableViewCell {
        
    private lazy var nameLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var factorImageView: UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var typeLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var view: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 7
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setConstraints()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .clear
        addSubview(view)
        view.addSubview(nameLabel)
        view.addSubview(typeLabel)
        view.addSubview(factorImageView)
    }
    
    public func cellConfigure(_ name: String, _ factor: Factor) {
        nameLabel.text = name.uppercased()
        typeLabel.text = factor.rawValue
        factorImageView.image = factor.image
        factorImageView.tintColor = factor.color
        switch factor {
        case .hight:
            view.backgroundColor = .specialPoor
        case .low:
            view.backgroundColor = .specialBest
        case .average:
            view.backgroundColor = .specialAverage
        }
    }
}

// MARK: - Set Constraints

extension IngredientTableViewCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6),
            view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 6),
            nameLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -6),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            nameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
        ])
        
        NSLayoutConstraint.activate([
            factorImageView.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            factorImageView.trailingAnchor.constraint(equalTo: typeLabel.leadingAnchor, constant: -8),
            factorImageView.heightAnchor.constraint(equalToConstant: 25),
            factorImageView.widthAnchor.constraint(equalToConstant: 25)
        ])
            
        NSLayoutConstraint.activate([
            typeLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            typeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            typeLabel.leadingAnchor.constraint(equalTo: factorImageView.trailingAnchor, constant: 8)
        ])
       
    }
}
