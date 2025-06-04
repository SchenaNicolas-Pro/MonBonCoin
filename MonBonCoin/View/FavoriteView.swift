//
//  FavoriteView.swift
//  MonBonCoin
//
//  Created by Nicolas Schena on 29/08/2023.
//

import UIKit

class FavoriteView: UIView {
    
    // MARK: - Search Bar
    let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Type", "Département"])
        
        let selectedAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.white,
                .font: UIFont.systemFont(ofSize: 18, weight: .semibold)
            ]
        
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 18, weight: .semibold)], for: .normal)
        segmentedControl.backgroundColor = .tabBarColor
        segmentedControl.selectedSegmentTintColor = UIColor.segmentedControlSelectedColor
        segmentedControl.setTitleTextAttributes(selectedAttributes, for: .normal)
        segmentedControl.setTitleTextAttributes(selectedAttributes, for: .selected)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    let filterView: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor.tabBarColor
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    // MARK: - Tableview
    let tableView = CustomTableView()
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.backgroundColor
        addSubview(filterView)
        filterView.addSubview(segmentedControl)
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: filterView.topAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: filterView.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: filterView.trailingAnchor),
            segmentedControl.bottomAnchor.constraint(equalTo: filterView.bottomAnchor, constant: -1)
        ])
        
        NSLayoutConstraint.activate([
            filterView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            filterView.leadingAnchor.constraint(equalTo: leadingAnchor),
            filterView.trailingAnchor.constraint(equalTo: trailingAnchor),
            filterView.heightAnchor.constraint(equalToConstant: 67)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: filterView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
