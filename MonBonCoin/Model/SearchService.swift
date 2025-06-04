//
//  SearchService.swift
//  MonBonCoin
//
//  Created by Nicolas Schena on 09/08/2023.
//

import Foundation

class SearchService {
    // MARK: - URLSession, Task
    private let conformateMethod = ConformateMethod()
    private let session: URLSession
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    func getInformation(url: URL, tag: String) async throws -> [LocationInformation] {
        let request = URLRequest(url: url)
        let (data, response) = try await session.data(from: request.url!)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        guard let responseJSON = try? JSONDecoder().decode(SearchElement.self, from: data) else {
            throw NetworkError.undecodableData
        }
        
        let conformatedResponse = self.conformateMethod.conformate(responseJSON, tag: tag)
        return conformatedResponse
    }
}
