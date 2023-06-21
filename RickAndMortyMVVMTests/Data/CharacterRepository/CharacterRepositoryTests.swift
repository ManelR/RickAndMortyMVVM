//
//  CharacterRepositoryTests.swift
//  RickAndMortyMVVMTests
//
//  Created by Manel Roca on 21/6/23.
//

import XCTest
@testable import RickAndMortyMVVM

final class CharacterRepositoryTests: BaseXCTestCase {

    private var sut: CharacterRepository!
    private var fakeJSONResponse = StubCharacterRepository.fakeJSONResponse

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
