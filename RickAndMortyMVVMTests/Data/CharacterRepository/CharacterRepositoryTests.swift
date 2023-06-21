//
//  CharacterRepositoryTests.swift
//  RickAndMortyMVVMTests
//
//  Created by Manel Roca on 21/6/23.
//

import XCTest
@testable import RickAndMortyMVVM

final class CharacterRepositoryTests: XCTestCase {

    private var sut: CharacterRepository!
    private var fakeJSONResponse = """
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

    override func setUp() {
        super.setUp()
        sut = CharacterRepository(client: SpyHTTPClient())
    }

    func test_getCharacters_Correct_URL() async throws {
        // Given
        let client = self.sut.client as! SpyHTTPClient
        // When
        do {
            _ = try await self.sut.getCharacters()
            // Then
            XCTAssertEqual(client.countSend, 1)
            XCTAssertEqual(client.request?.url?.absoluteString, "https://rickandmortyapi.com/api/character")
        } catch {
            XCTFail("This method should not throw")
        }
    }

    func test_getCharacters_Correct_Method() async throws {
        // Given
        let client = self.sut.client as! SpyHTTPClient
        // When
        do {
            _ = try await self.sut.getCharacters()
            // Then
            XCTAssertEqual(client.countSend, 1)
            XCTAssertEqual(client.request?.httpMethod, "GET")
        } catch {
            XCTFail("This method should not throw")
        }
    }

    func test_getCharacters_Correct_JSON_Response() async throws {
        // Given
        self.sut = CharacterRepository(client: MockHTTPClient(response: self.fakeJSONResponse, error: nil))
        // When
        do {
            let result = try await self.sut.getCharacters()
            // Then
            XCTAssertEqual(result?.count, 2)
            XCTAssertEqual(result![0].name, "Rick Sanchez")
            XCTAssertEqual(result![1].name, "Morty Smith")
        } catch {
            XCTFail("This method should not throw")
        }
    }

    func test_getCharacters_Wrong_JSON_Response() async throws {
        // Given
        self.sut = CharacterRepository(client: MockHTTPClient(response: "{ \"error\": true }", error: nil))
        // When
        do {
            let _ = try await self.sut.getCharacters()
        } catch {
            // Then
            XCTAssertEqual(error as? HTTPError, .JSONParseError)
        }
    }

    func test_getCharacters_Throws_Client_Errors() async throws {
        // Given
        self.sut = CharacterRepository(client: MockHTTPClient(response: "", error: HTTPError.timeout))
        // When
        do {
            let _ = try await self.sut.getCharacters()
        } catch {
            // Then
            XCTAssertEqual(error as? HTTPError, .timeout)
        }
    }
}
