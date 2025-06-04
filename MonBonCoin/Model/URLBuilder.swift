//
//  URLBuilder.swift
//  MonBonCoin
//
//  Created by Nicolas Schena on 18/09/2023.
//

import Foundation

enum URLBuilder {
    case department(category: String)
    
    func url(departmentNumber: String) -> URL {
        var components = URLComponents()
        
        components.scheme = "https"
        components.host = "monboncoin-fa07b-default-rtdb.europe-west1.firebasedatabase.app"
        
        switch self {
        case .department(let category):
            components.path = "/\(departmentNumber)/\(category)/@graph.json"
        }
        return components.url!
    }
}
