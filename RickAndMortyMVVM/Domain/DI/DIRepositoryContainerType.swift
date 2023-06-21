//
//  DIRepositoryContainerType.swift
//  RickAndMortyMVVM
//
//  Created by Manel Roca on 21/6/23.
//

import Foundation

protocol DIRepositoryContainerType {
    // MARK: - Repositories
    func resolve() -> CharacterRepositoryType

    // MARK: - HTTPClient
    func resolve() -> HTTPClientType
}
