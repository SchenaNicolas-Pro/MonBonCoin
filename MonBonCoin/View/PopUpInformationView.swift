//
//  PopUpInformationView.swift
//  MonBonCoin
//
//  Created by Nicolas Schena on 24/09/2023.
//

import UIKit

class PopUpInformationView: UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let informationLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    init(title: String) {
        super.init(frame: .zero)
        self.titleLabel.text = "- \(title) :"
        backgroundColor = .popUpBackgroundColor
        addSubview(titleLabel)
        addSubview(informationLabel)
        translatesAutoresizingMaskIntoConstraints = false
        
        let attributedString = NSMutableAttributedString.init(string: titleLabel.text!)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSRange.init(location: 2, length: attributedString.length - 4))
        titleLabel.attributedText = attributedString
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: 110)
        ])
        
        NSLayoutConstraint.activate([
            informationLabel.topAnchor.constraint(equalTo: topAnchor),
            informationLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant:  10),
            informationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            informationLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
