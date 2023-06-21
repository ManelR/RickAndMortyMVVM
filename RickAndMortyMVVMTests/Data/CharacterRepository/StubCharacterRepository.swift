//
//  StubCharacterRepository.swift
//  RickAndMortyMVVMTests
//
//  Created by Manel Roca on 21/6/23.
//

import Foundation
@testable import RickAndMortyMVVM

final class StubCharacterRepository: CharacterRepositoryType {
    public static var fakeJSONResponse = """
        {
    "info": {
        "count": 826,
        "pages": 42,
        "next": "https://rickandmortyapi.com/api/character?page=2",
        "prev": null
    },
    "results": [
        {
            "id": 1,
            "name": "Rick Sanchez",
            "status": "Alive",
            "species": "Human",
            "type": "",
            "gender": "Male",
            "origin": {
                "name": "Earth (C-137)",
                "url": "https://rickandmortyapi.com/api/location/1"
            },
            "location": {
                "name": "Citadel of Ricks",
                "url": "https://rickandmortyapi.com/api/location/3"
            },
            "image": "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
            "episode": [
                "https://rickandmortyapi.com/api/episode/1",
            ],
            "url": "https://rickandmortyapi.com/api/character/1",
            "created": "2017-11-04T18:48:46.250Z"
        },
        {
            "id": 2,
            "name": "Morty Smith",
            "status": "Alive",
            "species": "Human",
            "type": "",
            "gender": "Male",
            "origin": {
                "name": "unknown",
                "url": ""
            },
            "location": {
                "name": "Citadel of Ricks",
                "url": "https://rickandmortyapi.com/api/location/3"
            },
            "image": "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
            "episode": [
                "https://rickandmortyapi.com/api/episode/1",
            ],
            "url": "https://rickandmortyapi.com/api/character/2",
            "created": "2017-11-04T18:50:21.651Z"
        }
    ]
    }
    """

    func getCharacters() async throws -> [CharacterDomain]? {
        let decode = JSONDecoder()
        do {
            let result = try decode.decode(CharacterResponse.self, from: StubCharacterRepository.fakeJSONResponse.data(using: .utf8)!)
            return result.results.map { CharacterDomain(from: $0) }
        }
    }
}
