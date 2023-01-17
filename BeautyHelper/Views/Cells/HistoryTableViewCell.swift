//
//  HistoryTableViewCell.swift
//  BeautyHelper
//
//  Created by Максим Хмелев on 16.01.2023.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
        
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
    
    private func setupViews() {
        backgroundColor = .clear
        addSubview(nameLabel)
        addSubview(dateLabel)
    }
    
    public func cellConfigure(_ name: String, _ date: Date, _ indexPath: IndexPath) {
        let date = date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        let dateString = dateFormatter.string(from: date as Date)
        
        nameLabel.text = name + " № \(String(indexPath.row + 1))"
        dateLabel.text = dateString
    }
}

// MARK: - Set Constraints

extension HistoryTableViewCell {
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            nameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
        ])
            
        NSLayoutConstraint.activate([
            dateLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
       
    }
}

