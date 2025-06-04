//
//  SideMenuButton.swift
//  MonBonCoin
//
//  Created by Nicolas Schena on 11/09/2023.
//

import UIKit

class SideMenuButton: UIButton {
    
    var textLabel: UILabel = {
        let title = UILabel()
        title.textColor = .white
        title.translatesAutoresizingMaskIntoConstraints = false
        
        return title
    }()
    
    var categoryTag: UILabel = {
        let title = UILabel()
        
        return title
    }()

    let image: UIImageView = {
        let image = UIImageView()
        
        image.image = UIImage(systemName: "square")
        image.tintColor = .white
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    let bottomBlackBorder: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor.black
        
        return view
    }()
        
    init(title: String, eventTitle: String?) {
        super.init(frame: .zero)
        self.textLabel.text = title
        self.categoryTag.text = eventTitle
        backgroundColor = .menuColor
        layer.cornerRadius = 8.0
        addSubview(textLabel)
        addSubview(image)
        addSubview(bottomBlackBorder)
        
        NSLayoutConstraint.activate([
            textLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
        ])
        
        NSLayoutConstraint.activate([
            image.centerYAnchor.constraint(equalTo: centerYAnchor),
            image.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30)
        ])
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bottomBlackBorder.frame = (CGRect(x: 0, y: self.frame.height, width: self.frame.width, height: 2))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
