//
//  ListScene+DI.swift
//  RickAndMortyMVVM
//
//  Created by Manel Roca on 21/6/23.
//

import Foundation

extension DIRepositoryContainerType {
    func resolve() -> any ListSceneRouterType {
        return ListSceneRouter()
    }

    func resolve() -> any ListSceneViewModelType {
        return ListSceneViewModel()
    }
}
