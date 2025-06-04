//
//  LocationInformation.swift
//  MonBonCoin
//
//  Created by Nicolas Schena on 18/09/2023.
//

import Foundation

struct LocationInformation {
    let information: [String: String]

    init(title: String, phone: String, email: String, homepage: String, image: String, streetAddress: String, postalCode: String, locality: String, describe: String, openingHours: String, additionalSchedule: String, price: String, tag: String) {
        self.information = [
            "title": title,
            "phone": phone,
            "email": email,
            "homepage": homepage,
            "image": image,
            "streetAddress": streetAddress,
            "postalCode": postalCode,
            "locality": locality,
            "describe": describe,
            "openingHours": openingHours,
            "additionalSchedule": additionalSchedule,
            "price": price,
            "tag": tag
        ]
    }
}
