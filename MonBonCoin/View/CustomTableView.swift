//
//  CustomTableView.swift
//  MonBonCoin
//
//  Created by Nicolas Schena on 21/08/2023.
//

import UIKit

class CustomTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        backgroundColor = UIColor.tableViewColor
        separatorStyle = .none
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
