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
    
    private lazy var effectImageView: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(systemName: "leaf.fill")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var effectStackView = UIStackView()
    
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
        
        effectStackView = UIStackView(arrangedSubviews: [effectImageView, effectNameLabel], axis: .horizontal, aligment: .center, distribution: .equalSpacing, spacing: 8)
        addSubview(effectStackView)
    }
    
    func cellConfigure(_ effectName: String) {
        effectNameLabel.text = effectName
    }
}

// MARK: - Set Constraints

extension EffectCollectionViewCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            effectStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            effectStackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        NSLayoutConstraint.activate([
            effectImageView.widthAnchor.constraint(equalToConstant: 25),
            effectImageView.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
}
