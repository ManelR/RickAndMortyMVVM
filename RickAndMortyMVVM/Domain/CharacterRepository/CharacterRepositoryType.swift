//
//  DataRepositoryType.swift
//  RickAndMortyMVVM
//
//  Created by Manel Roca on 21/6/23.
//

import Foundation

protocol CharacterRepositoryType {
    func getCharacters() async throws -> [CharacterDomain]?
}
