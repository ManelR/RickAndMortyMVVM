//
//  MockHTTPClient.swift
//  RickAndMortyMVVMTests
//
//  Created by Manel Roca on 21/6/23.
//

import Foundation
@testable import RickAndMortyMVVM

final class MockHTTPClient: HTTPClientType {
    var response: String
    var error: Error?

    init(response: String, error: Error?) {
        self.response = response
        self.error = error
    }

    func send(request: URLRequest) async throws -> Data? {
        if let error = error {
            throw error
        }

        return response.data(using: .utf8)
    }
}
