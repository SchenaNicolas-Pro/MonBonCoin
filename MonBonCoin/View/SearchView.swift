//
//  SearchView.swift
//  MonBonCoin
//
//  Created by Nicolas Schena on 21/08/2023.
//

import UIKit

class SearchView: UIView {
    var closedConstraint = NSLayoutConstraint()
    var openedConstraint = NSLayoutConstraint()
    
    // MARK: - Search Bar
    let typeButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Type", for: .normal)
        button.backgroundColor = UIColor.menuColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2.0
        button.layer.cornerRadius = 8
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let departmentButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Département", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2.0
        button.layer.cornerRadius = 8
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let searchButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("GO", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2.0
        button.layer.cornerRadius = 8
        button.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    //MARK: - Shuffle Button
    let shuffleButton = ShuffleButton()
    
    let blackBorder: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor.black
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    // MARK: - Location Bar
    let locationView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8.0
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        
        return view
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .white
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    //MARK: - Side Menu
    let menuView = SideMenuView()
    
    // MARK: - Tableview
    let tableView = CustomTableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.backgroundColor
        
        addSubview(departmentButton)
        addSubview(typeButton)
        addSubview(shuffleButton)
        addSubview(locationView)
        addSubview(searchButton)
        locationView.addSubview(locationLabel)
        addSubview(tableView)
        shuffleButton.addSubview(blackBorder)
        addSubview(menuView)
        
        closedConstraint = menuView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -323)
        closedConstraint.isActive = true
        openedConstraint = menuView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -2)
        openedConstraint.isActive = false

        
        NSLayoutConstraint.activate([
            typeButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 25),
            typeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            typeButton.trailingAnchor.constraint(equalTo: departmentButton.leadingAnchor, constant: -8),
            typeButton.heightAnchor.constraint(equalToConstant: 39),
            typeButton.widthAnchor.constraint(equalToConstant: 95)
        ])
        
        NSLayoutConstraint.activate([
            shuffleButton.topAnchor.constraint(equalTo: locationView.bottomAnchor, constant: 20),
            shuffleButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            shuffleButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            shuffleButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        NSLayoutConstraint.activate([
            departmentButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 25),
            departmentButton.heightAnchor.constraint(equalToConstant: 39),
            departmentButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            locationView.topAnchor.constraint(equalTo: departmentButton.bottomAnchor, constant: 15),
            locationView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            locationView.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor),
            locationView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            searchButton.topAnchor.constraint(equalTo: departmentButton.bottomAnchor, constant: 15),
            searchButton.leadingAnchor.constraint(equalTo: locationView.trailingAnchor),
            searchButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            searchButton.heightAnchor.constraint(equalToConstant: 60),
            searchButton.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: locationView.topAnchor, constant: 8),
            locationLabel.leadingAnchor.constraint(equalTo: locationView.leadingAnchor, constant: 16),
            locationLabel.trailingAnchor.constraint(equalTo: locationView.trailingAnchor, constant: -8),
            locationLabel.bottomAnchor.constraint(equalTo: locationView.bottomAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: shuffleButton.bottomAnchor, constant: 1),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            blackBorder.topAnchor.constraint(equalTo: shuffleButton.bottomAnchor),
            blackBorder.leadingAnchor.constraint(equalTo: leadingAnchor),
            blackBorder.trailingAnchor.constraint(equalTo: trailingAnchor),
            blackBorder.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            menuView.topAnchor.constraint(equalTo: typeButton.topAnchor),
            menuView.heightAnchor.constraint(equalToConstant: 372),
            menuView.widthAnchor.constraint(equalToConstant: 323)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
