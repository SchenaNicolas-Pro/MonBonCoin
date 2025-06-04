//
//  URLBuilderTestCase.swift
//  MonBonCoinTests
//
//  Created by Nicolas Schena on 09/01/2024.
//

import XCTest
@testable import MonBonCoin

final class URLBuilderTestCase: XCTestCase {
    func testURLBuilderShouldBuildCorrectURL() {
        let department = "01"
        let category = "Restauration"
        
        let expectedURL = URL(string: "https://monboncoin-fa07b-default-rtdb.europe-west1.firebasedatabase.app/01/Restauration/@graph.json")
        
        let url = URLBuilder.department(category: category).url(departmentNumber: department)
        
        XCTAssertEqual(url, expectedURL)
    }
}
