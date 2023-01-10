//
//  EffectCollectionViewCell.swift
//  BeautyHelper
//
//  Created by Максим Хмелев on 14.12.2022.
//

import UIKit

class EffectCollectionViewCell: UICollectionViewCell {
    
    private lazy var effectNameLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .specialCell
        layer.cornerRadius = 10
 
        addSubview(effectNameLabel)
    }
    
    func cellConfigure(_ effectName: String) {
        effectNameLabel.text = effectName
    }
}

// MARK: - Set Constraints

extension EffectCollectionViewCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            effectNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            effectNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
