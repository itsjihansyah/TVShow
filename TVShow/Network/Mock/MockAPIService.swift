//
//  MockAPIService.swift
//  TVShow
//
//  Created by Jihan Syahira Adnanda Putri on 29/07/26.
//

import Foundation

final class MockAPIService: APIServiceProtocol {

    var result: Result<Any, Error> = .failure(MockError.notConfigured)

    private(set) var lastRequest: APIRequest?
    private(set) var callCount = 0

    func fetchData<T: Decodable>(request: APIRequest) async throws -> T {
        callCount += 1
        lastRequest = request

        switch result {
        case .success(let value):
            guard let value = value as? T else {
                throw MockError.invalidStub
            }
            return value

        case .failure(let error):
            throw error
        }
    }
}

enum MockError: Error, Equatable {
    case notConfigured
    case invalidStub
    case network
}
