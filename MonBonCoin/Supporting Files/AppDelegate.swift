//
//  AppDelegate.swift
//  MonBonCoin
//
//  Created by Nicolas Schena on 09/08/2023.
//

import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    lazy var coreDataStack = CoreDataStack()
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions:
                     [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}


