//
//  PopUpView.swift
//  MonBonCoin
//
//  Created by Nicolas Schena on 29/08/2023.
//

import UIKit

class PopUpView: UIView {
    var closedConstraint = NSLayoutConstraint()
    var openedConstraint = NSLayoutConstraint()
    
    let titleDictionnary = ["Restauration": "Restauration",
                            "Cultural": "Cultural Site",
                            "Sport": "Sport and Fun",
                            "Ride": "Walk and Bike Site",
                            "Event": "Events"]
    
    let backButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.imageView?.tintColor = .white
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 30), forImageIn: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let title: UILabel = {
        let label = UILabel()
        
        label.text = "Title"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        let attributedString = NSMutableAttributedString.init(string: label.text!)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSRange.init(location: 0, length: attributedString.length))
        label.attributedText = attributedString
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let image: UIImageView = {
        let image = UIImageView()
        
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    let goButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("GO", for: .normal)
        button.setTitleColor(.goButtonColor, for: .normal)
        button.backgroundColor = UIColor.white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.layer.cornerRadius = 8
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let favoriteButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.imageView?.tintColor = .backgroundColor
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 44), forImageIn: .normal)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 0
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let informationTextLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Information :"
        label.textColor = .white
        let attributedString = NSMutableAttributedString.init(string: label.text!)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSRange.init(location: 0, length: attributedString.length - 2))
        label.attributedText = attributedString
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
   
    let tableView:  UITableView = {
        let tableView = UITableView()
        
        tableView.backgroundColor = .popUpBackgroundColor
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .popUpBackgroundColor
        addSubview(backButton)
        addSubview(title)
        addSubview(image)
        addSubview(goButton)
        addSubview(favoriteButton)
        addSubview(informationTextLabel)
        addSubview(tableView)
        
        closedConstraint = image.heightAnchor.constraint(equalToConstant: 0)
        closedConstraint.isActive = true
        openedConstraint = image.heightAnchor.constraint(equalToConstant: 153)
        openedConstraint.isActive = false
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            title.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 20),
            image.centerXAnchor.constraint(equalTo: centerXAnchor),
            image.widthAnchor.constraint(equalToConstant: 328)
        ])
        
        NSLayoutConstraint.activate([
            goButton.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 30),
            goButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            goButton.heightAnchor.constraint(equalToConstant: 44),
            goButton.widthAnchor.constraint(equalToConstant: 88)
        ])
        
        NSLayoutConstraint.activate([
            favoriteButton.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 30),
            trailingAnchor.constraint(equalTo: favoriteButton.trailingAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            informationTextLabel.topAnchor.constraint(equalTo: goButton.bottomAnchor, constant: 40),
            informationTextLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: informationTextLabel.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
