//
//  PopUpTableViewCell.swift
//  MonBonCoin
//
//  Created by Nicolas Schena on 29/09/2023.
//

import UIKit

class PopUpTableViewCell: UITableViewCell {
    static let identifier = "popUpCell"
    
    let categoryText: UILabel = {
        let label = UILabel()
        
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let informationText: UILabel = {
        let label = UILabel()
        
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)

        contentView.backgroundColor = UIColor.popUpBackgroundColor
        addSubview(categoryText)
        addSubview(informationText)
        
        NSLayoutConstraint.activate([
            categoryText.topAnchor.constraint(equalTo: topAnchor),
            categoryText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            categoryText.widthAnchor.constraint(equalToConstant: 120)
        ])
        
        NSLayoutConstraint.activate([
            informationText.topAnchor.constraint(equalTo: topAnchor),
            informationText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            informationText.leadingAnchor.constraint(equalTo: categoryText.trailingAnchor, constant: 30),
            informationText.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
