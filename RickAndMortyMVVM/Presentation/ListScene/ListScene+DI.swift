//
//  ListScene+DI.swift
//  RickAndMortyMVVM
//
//  Created by Manel Roca on 21/6/23.
//

import Foundation

extension DIRepositoryContainerProtocol {
    func resolve() -> any ListSceneRouterType {
        return ListSceneRouter()
    }

    func resolve() -> ListSceneViewModelType {
        return ListSceneViewModel()
    }
}
