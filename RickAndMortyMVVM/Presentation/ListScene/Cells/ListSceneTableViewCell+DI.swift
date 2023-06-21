//
//  ListSceneTableViewCell+DI.swift
//  RickAndMortyMVVM
//
//  Created by Manel Roca on 21/6/23.
//

import Foundation

extension DIRepositoryContainerType {
    func resolve() -> ListSceneTableViewCellModelType {
        return ListSceneTableViewCellModel()
    }
}
