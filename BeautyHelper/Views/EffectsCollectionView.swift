//
//  EffectsCollectionView.swift
//  BeautyHelper
//
//  Created by Максим Хмелев on 14.12.2022.
//

import UIKit

class EffectsCollectionView: UICollectionView {
    
    private let effectLayout = UICollectionViewFlowLayout()
    
    var ingredient: Ingredient?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: effectLayout)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        effectLayout.minimumInteritemSpacing = 8
        effectLayout.scrollDirection = .horizontal
        
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        showsHorizontalScrollIndicator = false
        delegate = self
        dataSource = self
        register(EffectCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
}

// MARK: - UICollectionViewDataSource

extension EffectsCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        ingredient?.category.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? EffectCollectionViewCell {
            cell.cellConfigure(ingredient?.category[indexPath.row] ?? "Без категории")
            
            return cell
        }
        return UICollectionViewCell()
    } 
}

// MARK: - UICollectionViewDelegate

extension EffectsCollectionView: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewFlowLayout

extension EffectsCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellFont = UIFont.systemFont(ofSize: 16)
        let cellAttributes = [NSAttributedString.Key.font : cellFont as Any]
        if let cellWidth = ingredient?.category[indexPath.row].size(withAttributes: cellAttributes).width {
            return CGSize(width: cellWidth + 20, height: collectionView.frame.height)
        }
        return CGSize(width: 200, height: collectionView.frame.height)
    }
}
