//
//  Character.swift
//  RickAndMortyMVVM
//
//  Created by Manel Roca on 21/6/23.
//

import Foundation

struct CharacterResponse: Codable {
    var results: [CharacterResponse.Character]

    struct Character: Codable {
        var id: Int
        var name: String
    }
}
