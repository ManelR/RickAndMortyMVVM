//
//  DataRepositoryType.swift
//  RickAndMortyMVVM
//
//  Created by Manel Roca on 21/6/23.
//

import Foundation

protocol CharacterRepositoryType {
    func getCharacters(filter: String?) async throws -> [CharacterDomain]?
}

extension CharacterRepositoryType {
    func getCharacters(filter: String? = nil) async throws -> [CharacterDomain]? {
        return try await getCharacters(filter: filter)
    }
}
