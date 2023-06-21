//
//  DIRepository.swift
//  RickAndMortyMVVM
//
//  Created by Manel Roca on 21/6/23.
//

import Foundation

class DIRepository {

    private static var initialized: DIRepositoryContainerType?

    public static var shared: DIRepositoryContainerType {
        return initialized ?? DIRepositoryContainer()
    }

    public static func initialize(_ initialized: DIRepositoryContainerType) {
        self.initialized = initialized
    }
}
