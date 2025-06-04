//
//  SceneDelegate.swift
//  MonBonCoin
//
//  Created by Nicolas Schena on 09/08/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    private func setUpControllers() -> TabBarController {
        let tabBarController = TabBarController()
        let searchView = SearchViewController()
        searchView.title = "Rechercher"
        let favoriteView = FavoriteViewController()
        favoriteView.title = "Favoris"
        let historyView = HistoryViewController()
        historyView.title = "Historique"
        tabBarController.viewControllers = [searchView, favoriteView, historyView]
        return tabBarController
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let tabBarController = setUpControllers()
        let isFirstLaunch = UserDefaults.standard.bool(forKey: "isFirstLaunch")
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        if isFirstLaunch == false {
            let firstLaunchViewController = FirstLaunchViewController()
            firstLaunchViewController.isModalInPresentation = true
            firstLaunchViewController.delegate = tabBarController.viewControllers?.first(where: { $0 is SearchViewController}) as? SearchViewController
            firstLaunchViewController.departmentViewController.delegate = tabBarController.viewControllers?.first(where: { $0 is SearchViewController}) as? SearchViewController
            
            self.window?.rootViewController?.present(firstLaunchViewController, animated: true)
            UserDefaults.standard.set(true, forKey: "isFirstLaunch")
        }
    }
}

