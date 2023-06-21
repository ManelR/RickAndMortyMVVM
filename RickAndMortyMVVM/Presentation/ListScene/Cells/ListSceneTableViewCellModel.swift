//
//  ListSceneTableViewCellModel.swift
//  RickAndMortyMVVM
//
//  Created by Manel Roca on 21/6/23.
//

import Foundation

// INPUT DEFINITION
protocol ListSceneTableViewCellModelInput {
    func configView(from: CharacterDomain)
}

// OUTPUT DEFINITION
protocol ListSceneTableViewCellModelOutput {
    var titleText: Published<String?>.Publisher { get }
    var secondaryText: Published<String?>.Publisher { get }
    var showAlive: Published<Bool?>.Publisher { get }
    var imageData: Published<Data?>.Publisher { get }
}

// PROTOCOL COMPOSITION
protocol ListSceneTableViewCellModelType: ListSceneTableViewCellModelInput, ListSceneTableViewCellModelOutput {
}

final class ListSceneTableViewCellModel: ListSceneTableViewCellModelType {
    @Published var pTitle: String?
    var titleText: Published<String?>.Publisher { $pTitle }
    @Published var pSecondaryText: String?
    var secondaryText: Published<String?>.Publisher { $pSecondaryText }
    @Published var pShowAlive: Bool?
    var showAlive: Published<Bool?>.Publisher { $pShowAlive }
    @Published var pImageData: Data?
    var imageData: Published<Data?>.Publisher { $pImageData }


    func configView(from character: CharacterDomain) {
        self.pTitle = character.name
        self.pSecondaryText = character.species
        self.pShowAlive = character.isAlive
        
    }
}
