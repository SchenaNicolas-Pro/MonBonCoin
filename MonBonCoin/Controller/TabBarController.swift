//
//  TabBarController.swift
//  MonBonCoin
//
//  Created by Nicolas Schena on 14/08/2023.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fontForTabBar()
        tabBar.backgroundColor = UIColor.tabBarColor
        tabBar.tintColor = .white
        tabBar.barTintColor = UIColor.tabBarColor
        tabBar.unselectedItemTintColor = .lightGray
    }
    
    private func fontForTabBar() {
        let font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: font], for: .selected)
    }
}
