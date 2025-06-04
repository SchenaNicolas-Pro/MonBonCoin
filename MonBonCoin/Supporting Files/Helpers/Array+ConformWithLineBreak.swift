//
//  Array+ConformWithLineBreak.swift
//  MonBonCoin
//
//  Created by Nicolas Schena on 16/01/2024.
//

import Foundation

// More a test than a real utility
extension Array where Element == String {
    public func conformWithLineBreak() -> String {
        return self.joined(separator: "\n")
    }
}
