//
//  HistoryTableViewCell.swift
//  BeautyHelper
//
//  Created by Максим Хмелев on 16.01.2023.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "product")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
        
    private lazy var nameLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        productImageView.image = UIImage(named: "product")
    }
    
    private func setupViews() {
        backgroundColor = .clear
        addSubview(productImageView)
        addSubview(nameLabel)
        addSubview(dateLabel)
    }
    
    public func cellConfigure(_ name: String, _ date: Date,_ imageData: Data?, _ indexPath: IndexPath) {
        let date = date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        let dateString = dateFormatter.string(from: date as Date)
        
        if let imageData = imageData {
            let image = UIImage(data: imageData)
            productImageView.image = image
        }
        
        nameLabel.text = name + " № \(String(indexPath.row + 1))"
        dateLabel.text = dateString
    }
}

// MARK: - Set Constraints

extension HistoryTableViewCell {
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            productImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            productImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            productImageView.heightAnchor.constraint(equalToConstant: 50),
            productImageView.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: productImageView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 8),
            nameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7)
        ])
            
        NSLayoutConstraint.activate([
            dateLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
       
    }
}

