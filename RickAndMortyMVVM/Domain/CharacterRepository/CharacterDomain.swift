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
}

extension CharacterDomain {
    init(from: CharacterResponse.Character) {
        self.id = from.id
        self.name = from.name
    }
}
