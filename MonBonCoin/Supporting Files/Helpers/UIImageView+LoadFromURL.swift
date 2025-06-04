//
//  UIImageView+LoadFromURL.swift
//  MonBonCoin
//
//  Created by Nicolas Schena on 24/09/2023.
//

import UIKit

// Dispatch image loading
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
