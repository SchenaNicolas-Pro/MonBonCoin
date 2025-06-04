//
//  FakeResponseData.swift
//  MonBonCoinTests
//
//  Created by Nicolas Schena on 09/01/2024.
//

import Foundation

class FakeResponseData {
    static let fakeURL = URL(string: "https://www.a-url.com")!
    
    static let falseData = "a data".data(using: .utf8)
    
    static let responseOk = HTTPURLResponse(url: URL(string: "https://a-url.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    
    static let responseKo = HTTPURLResponse(url: URL(string: "https://a-url.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    static var correctData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "SearchData", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static var emptyData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "EmptyData", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
}
