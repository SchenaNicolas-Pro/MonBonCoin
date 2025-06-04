//
//  FirstLaunchView.swift
//  MonBonCoin
//
//  Created by Nicolas Schena on 30/10/2023.
//

import UIKit

class FirstLaunchView: UIView {
    
    let labelText: UILabel = {
        let label = UILabel()
        
        label.text = "Veuillez sélectionner un département, afin de commencer votre aventure."
        label.textColor = .white
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let nextButton: UIButton = {
        let button = UIButton()
        
        button.isEnabled = false
        button.setTitle("next", for: .normal)
        button.setTitleColor(.systemGray, for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 8.0
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let tableView : UITableView = {
        let tableview = UITableView()
        
        tableview.separatorStyle = .none
        tableview.translatesAutoresizingMaskIntoConstraints = false
        
        return tableview
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(labelText)
        addSubview(nextButton)
        addSubview(tableView)
        backgroundColor = .popUpBackgroundColor
        
        NSLayoutConstraint.activate([
            labelText.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            labelText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            labelText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            nextButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            nextButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            nextButton.heightAnchor.constraint(equalToConstant: 35),
            nextButton.widthAnchor.constraint(equalToConstant: 55)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: labelText.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
