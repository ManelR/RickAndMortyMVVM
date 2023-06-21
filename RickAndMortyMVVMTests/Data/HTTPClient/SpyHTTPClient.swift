//
//  SpyHTTPClient.swift
//  RickAndMortyMVVMTests
//
//  Created by Manel Roca on 21/6/23.
//

import Foundation
@testable import RickAndMortyMVVM

final class SpyHTTPClient: HTTPClientType {
    var request: URLRequest?
    var countSend: Int = 0

    func send(request: URLRequest) async throws -> Data? {
        self.request = request
        self.countSend += 1
        return nil
    }

}
