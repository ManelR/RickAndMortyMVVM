//
//  HTTPClientType.swift
//  RickAndMortyMVVM
//
//  Created by Manel Roca on 21/6/23.
//

import Foundation

protocol HTTPClientType {
    func send(request: URLRequest) async throws -> Data?
}
