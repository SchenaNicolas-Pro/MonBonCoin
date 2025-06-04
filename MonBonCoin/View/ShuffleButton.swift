//
//  ShuffleButton.swift
//  MonBonCoin
//
//  Created by Nicolas Schena on 29/08/2023.
//

import UIKit

class ShuffleButton: UIButton {
    
    let title: UILabel = {
        let title = UILabel()
        title.text = "Aléatoire"
        title.textColor = .black
        title.translatesAutoresizingMaskIntoConstraints = false
        
        return title
    }()
    
    let image: UIImageView = {
        let image = UIImageView()
        
        image.image = UIImage(systemName: "shuffle")
        image.tintColor = .black
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .tableViewColor
        addSubview(title)
        addSubview(image)
        
        NSLayoutConstraint.activate([
            title.centerYAnchor.constraint(equalTo: centerYAnchor),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            image.centerYAnchor.constraint(equalTo: centerYAnchor),
            image.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: 10)
        ])
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
