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
        var species: String
        var image: String
        var status: CharacterResponse.Status?

    }

    enum Status: String, Codable {
        case alive
        case dead
        case unknown

        public init(from decoder: Decoder) throws {
            self = try Status(rawValue: decoder.singleValueContainer().decode(RawValue.self).lowercased()) ?? .unknown
        }
    }
}
