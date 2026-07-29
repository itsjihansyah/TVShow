//
//  APIService.swift
//  TVShow
//
//  Created by Jihan Syahira Adnanda Putri on 29/07/26.
//

import Foundation

typealias Parameters = [String: String]

struct APIRequest {
    let endpoint: Endpoint
    var params: Parameters = [:]
}

protocol APIServiceProtocol {
    func fetchData<T: Decodable>(request: APIRequest) async throws -> T
}

enum APIServiceError: Error {
    case invalidResponse
}

final class APIService: APIServiceProtocol {
    func fetchData<T: Decodable>(request: APIRequest) async throws -> T {
        let request = try URLRequestBuilder.build(request: request)
        let decoder = JSONDecoder()
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode) else {
                throw APIServiceError.invalidResponse
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .custom { decoder in
                let container = try decoder.singleValueContainer()
                let dateString = try container.decode(String.self)
                
                let formatter = DateFormatter()
                formatter.locale = Locale(identifier: "en_US_POSIX")
                formatter.dateFormat = "yyyy-MM-dd"
                
                guard let date = formatter.date(from: dateString) else {
                    throw DecodingError.dataCorruptedError(
                        in: container,
                        debugDescription: "Invalid date format: \(dateString)"
                    )
                }
                return date
            }
            return try decoder.decode(T.self, from: data)
        } catch {
            throw error
        }
    }
}
