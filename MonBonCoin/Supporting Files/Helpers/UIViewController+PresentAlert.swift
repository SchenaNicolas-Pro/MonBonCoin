//
//  UIViewController+PresentAlert.swift
//  MonBonCoin
//
//  Created by Nicolas Schena on 18/09/2023.
//

import UIKit

// Present Alert Extension
extension UIViewController {
    func presentAlert(_ message: String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}

// Personal error case
enum NetworkError: String, Error {
    case noData = "No Data available"
    case invalidResponse = "Wrong response code"
    case undecodableData = "Cannot decode Data"
    case unconformable = "Didn't succeeded to conform Data"
}
