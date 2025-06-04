//
//  ConformateMethodTestCase.swift
//  MonBonCoinTests
//
//  Created by Nicolas Schena on 30/01/2024.
//

import XCTest
@testable import MonBonCoin

final class ConformateMethodTestCase: XCTestCase {
    var data = SearchElement()
    
    private func switchNilInOpensClosesHours(inverseHours: Bool) -> SchemaOpeningHoursSpecification {
        if inverseHours == true {
            let fakeOpeningHours = SchemaOpeningHoursSpecification(additionalInformation: nil, schemaCloses: "07:00", schemaOpens: nil, schemaValidFrom: nil, schemaValidThrough: nil)
            return fakeOpeningHours
        } else {
            let fakeOpeningHours = SchemaOpeningHoursSpecification(additionalInformation: nil, schemaCloses: nil, schemaOpens: "07:00", schemaValidFrom: nil, schemaValidThrough: nil)
            return fakeOpeningHours
        }
    }
    
    func testGivenWhenThen() {
        let conformateService = ConformateMethod()
        let fakeLocated: IsLocatedAt? = nil
        let firstHours = switchNilInOpensClosesHours(inverseHours: true)
        let secondHours = switchNilInOpensClosesHours(inverseHours: false)
        
        let firstInformation = SearchElementClass(hasContact: [], hasRepresentation: [], isLocatedAt: fakeLocated, rdfsComment: [], rdfsLabel: [], schemaOpeningHoursSpecification: [firstHours], startDate: nil, endDate: nil, schemaMaxPrice: ["10"], schemaMinPrice: nil, schemaPriceCurrency: nil)
        
        let secondInformation = SearchElementClass(hasContact: [], hasRepresentation: [], isLocatedAt: fakeLocated, rdfsComment: [], rdfsLabel: [], schemaOpeningHoursSpecification: [secondHours], startDate: nil, endDate: nil, schemaMaxPrice: [], schemaMinPrice: [""], schemaPriceCurrency: nil)
        
        data.append(firstInformation)
        data.append(secondInformation)
        
        let conformData = conformateService.conformate(data, tag: "")
        
        XCTAssertEqual(conformData[0].information["price"], "")
        XCTAssertEqual(conformData[0].information["openingHours"], "")
    }
}
