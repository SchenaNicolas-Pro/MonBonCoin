//
//  DepartmentView.swift
//  MonBonCoin
//
//  Created by Nicolas Schena on 30/10/2023.
//

import UIKit

class DepartmentView: UIView {
    
    let tableView : UITableView = {
        let tableview = UITableView()
        
        tableview.separatorStyle = .none
        tableview.translatesAutoresizingMaskIntoConstraints = false
        
        return tableview
    }()
    
    let returnButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.imageView?.tintColor = .white
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 30), forImageIn: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let returnLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .white
        label.text = "Return"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .popUpBackgroundColor
        addSubview(tableView)
        addSubview(returnButton)
        addSubview(returnLabel)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 60),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            returnButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            returnButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            returnLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            returnLabel.leadingAnchor.constraint(equalTo: returnButton.trailingAnchor, constant: 20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
