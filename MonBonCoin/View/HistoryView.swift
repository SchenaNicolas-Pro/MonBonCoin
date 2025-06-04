//
//  HistoryView.swift
//  MonBonCoin
//
//  Created by Nicolas Schena on 29/12/2023.
//

import UIKit

class HistoryView: UIView {
    let tableView = CustomTableView()
     
        override init(frame: CGRect) {
            super.init(frame: frame)
            backgroundColor = UIColor.backgroundColor
            addSubview(tableView)
            
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
                tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
            ])
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}
