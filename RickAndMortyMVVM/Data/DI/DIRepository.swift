//
//  DIRepository.swift
//  RickAndMortyMVVM
//
//  Created by Manel Roca on 21/6/23.
//

import Foundation

class DIRepository {

    private static var initialized: DIRepositoryContainerProtocol?

    public static var shared: DIRepositoryContainerProtocol {
        return initialized ?? DIRepositoryContainer()
    }

    public static func initialize(_ initialized: DIRepositoryContainerProtocol) {
        self.initialized = initialized
    }
}
