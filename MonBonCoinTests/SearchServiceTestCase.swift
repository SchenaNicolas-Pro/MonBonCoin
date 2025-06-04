//
//  SearchServiceTestCase.swift
//  MonBonCoinTests
//
//  Created by Nicolas Schena on 16/01/2024.
//

import XCTest
@testable import MonBonCoin

final class SearchServiceTestCase: XCTestCase {
    
    //MARK: - Test code is Invalid
    func testGetInformationShouldFailedIfResponseCodeIsInvalid() async {
        URLProtocolStub.stub(data: .none,
                             response: FakeResponseData.responseKo,
                             error: .none)
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = URLSession(configuration: configuration)
        let sut = SearchService(session: session)
        
        let expectation = expectation(description: "waiting ...")
        
        do {
            try await sut.getInformation(url: FakeResponseData.fakeURL, tag: "")
        } catch {
            XCTAssertEqual(error as! NetworkError, NetworkError.invalidResponse)
        }
        
        expectation.fulfill()
        
        await fulfillment(of: [expectation], timeout: 0.1)
    }
    
    func testGetInformationShouldFailedIfIncorrectData() async {
        URLProtocolStub.stub(data: FakeResponseData.falseData,
                             response: FakeResponseData.responseOk,
                             error: .none)
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = URLSession(configuration: configuration)
        let sut = SearchService(session: session)
        
        let expectation = expectation(description: "waiting ...")
        
        do {
            try await sut.getInformation(url: FakeResponseData.fakeURL, tag: "")
        } catch {
            XCTAssertEqual(error as! NetworkError, NetworkError.undecodableData)
        }
        
        expectation.fulfill()
        
        await fulfillment(of: [expectation], timeout: 0.1)
    }
    
    func testGetInformationShouldSucceedWithEmptyArray() async {
        URLProtocolStub.stub(data: FakeResponseData.emptyData,
                             response: FakeResponseData.responseOk,
                             error: .none)
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = URLSession(configuration: configuration)
        let sut = SearchService(session: session)
        
        let expectation = expectation(description: "waiting ...")
        let response = try! await sut.getInformation(url: FakeResponseData.fakeURL, tag: "Restauration")
        
        XCTAssertEqual(response[0].information["title"], "")
        XCTAssertEqual(response[0].information["phone"], "")
        XCTAssertEqual(response[0].information["email"], "")
        XCTAssertEqual(response[0].information["homepage"], "")
        XCTAssertEqual(response[0].information["image"], "")
        XCTAssertEqual(response[0].information["streetAddress"], "")
        XCTAssertEqual(response[0].information["postalCode"], "")
        XCTAssertEqual(response[0].information["locality"], "")
        XCTAssertEqual(response[0].information["describe"], "")
        XCTAssertEqual(response[0].information["openingHours"], "")
        XCTAssertEqual(response[0].information["additionalSchedule"], "")
        XCTAssertEqual(response[0].information["price"], "")
        XCTAssertEqual(response[0].information["tag"], "Restauration")
        
        expectation.fulfill()
        
        await fulfillment(of: [expectation], timeout: 0.1)
    }
    
    func testGetInformationShouldSucceed() async {
        URLProtocolStub.stub(data: FakeResponseData.correctData,
                             response: FakeResponseData.responseOk,
                             error: .none)
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = URLSession(configuration: configuration)
        let sut = SearchService(session: session)
        
        let expectation = expectation(description: "waiting ...")
        let response = try! await sut.getInformation(url: FakeResponseData.fakeURL, tag: "Restauration")
        
        XCTAssertEqual(response[0].information["title"], StaticSearchDataResponse.title)
        XCTAssertEqual(response[0].information["phone"], StaticSearchDataResponse.phone)
        XCTAssertEqual(response[0].information["email"], StaticSearchDataResponse.email)
        XCTAssertEqual(response[0].information["homepage"], StaticSearchDataResponse.homepage)
        XCTAssertEqual(response[0].information["image"], StaticSearchDataResponse.image)
        XCTAssertEqual(response[0].information["streetAddress"], StaticSearchDataResponse.streetAddress)
        XCTAssertEqual(response[0].information["postalCode"], StaticSearchDataResponse.postalCode)
        XCTAssertEqual(response[0].information["locality"], StaticSearchDataResponse.locality)
        XCTAssertEqual(response[0].information["describe"], StaticSearchDataResponse.describe)
        XCTAssertEqual(response[0].information["openingHours"], StaticSearchDataResponse.openingHours)
        XCTAssertEqual(response[0].information["additionalSchedule"], StaticSearchDataResponse.additionalSchedule)
        XCTAssertEqual(response[0].information["price"], StaticSearchDataResponse.price)
        XCTAssertEqual(response[0].information["tag"], "Restauration")
        
        expectation.fulfill()
        
        await fulfillment(of: [expectation], timeout: 0.1)
    }
}
