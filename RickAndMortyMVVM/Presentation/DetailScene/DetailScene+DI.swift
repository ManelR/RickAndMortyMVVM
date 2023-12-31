//
//  DetailScene+DI.swift
//  RickAndMortyMVVM
//
//  Created by Manel Roca on 21/6/23.
//

import Foundation

extension DIRepositoryContainerType {
    func resolve() -> any DetailSceneRouterType {
        return DetailSceneRouter()
    }

    func resolve() -> DetailSceneViewModelType {
        return DetailSceneViewModel()
    }
}
