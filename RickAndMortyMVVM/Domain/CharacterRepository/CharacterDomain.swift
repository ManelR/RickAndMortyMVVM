//
//  CharacterDomain.swift
//  RickAndMortyMVVM
//
//  Created by Manel Roca on 21/6/23.
//

import Foundation

struct CharacterDomain {
    var id: Int
    var name: String
    var species: String
    var isAlive: Bool
    var image: String
}

extension CharacterDomain {
    init(from character: CharacterResponse.Character) {
        self.id = character.id
        self.name = character.name
        self.species = character.species
        self.isAlive = character.status != .dead
        self.image = character.image
    }
}
