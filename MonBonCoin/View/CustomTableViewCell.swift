//
//  CustomTableViewCell.swift
//  MonBonCoin
//
//  Created by Nicolas Schena on 15/08/2023.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    static let identifier = "customCell"
    
    let bottomBlackBorder: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor.black
        
        return view
    }()
    
    let selectedBackgroundViewColor: UIView = {
        let view = UIView()
        
        view.backgroundColor = .tableViewColor
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        selectedBackgroundView = selectedBackgroundViewColor
        
        backgroundColor = UIColor.tableViewColor
        addSubview(bottomBlackBorder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bottomBlackBorder.frame = (CGRect(x: 0, y: contentView.frame.maxY - 1, width: contentView.frame.width, height: 0.8))
    }
}
