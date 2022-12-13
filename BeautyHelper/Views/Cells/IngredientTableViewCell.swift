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
    
    private lazy var effectLabel: UILabel = {
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
        view.addSubview(effectLabel)
    }
    
    public func cellConfigure(_ name: String, _ effect: TypeEnum) {
        nameLabel.text = name.uppercased()
        effectLabel.text = effect.value
        switch effect {
        case .best:
            view.backgroundColor = .specialBest
        case .good:
            view.backgroundColor = .specialGood
        case .average:
            view.backgroundColor = .specialAverage
        case .poor:
            view.backgroundColor = .specialPoor
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
            effectLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            effectLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            effectLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 8)
        ])
       
    }
}
