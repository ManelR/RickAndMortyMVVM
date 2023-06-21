//
//  MockDIRepositoryContainer.swift
//  RickAndMortyMVVMTests
//
//  Created by Manel Roca on 21/6/23.
//

import Foundation
@testable import RickAndMortyMVVM

final class MockDIRespositoryContainer: DIRepositoryContainerType {
    // MARK: - Repositories
    func resolve() -> CharacterRepositoryType {
        return StubCharacterRepository()
    }

    func resolve() -> DownloadImageRepositoryType {
        // TODO:
        return DownloadImageRepository()
    }

    // MARK: - HTTPClient
    func resolve() -> HTTPClientType {
        return SpyHTTPClient()
    }
}
