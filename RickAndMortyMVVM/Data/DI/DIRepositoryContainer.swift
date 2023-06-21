//
//  DIRepositoryContainer.swift
//  RickAndMortyMVVM
//
//  Created by Manel Roca on 21/6/23.
//

import Foundation

final class DIRepositoryContainer: DIRepositoryContainerType {
    // MARK: - Repositories
    func resolve() -> CharacterRepositoryType {
        return CharacterRepository()
    }

    func resolve() -> DownloadImageRepositoryType {
        return DownloadImageRepository()
    }

    // MARK: - HTTPClient
    func resolve() -> HTTPClientType {
        return HTTPClient(session: .shared)
    }
}
