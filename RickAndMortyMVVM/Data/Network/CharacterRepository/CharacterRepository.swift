//
//  DataRepository.swift
//  RickAndMortyMVVM
//
//  Created by Manel Roca on 21/6/23.
//

import Foundation

final class CharacterRepository: CharacterRepositoryType {
    internal let url: URL?
    internal var client: HTTPClientType
    internal var decoder: JSONDecoder

    init(client: HTTPClientType = DIRepository.shared.resolve()) {
        self.client = client
        self.decoder = JSONDecoder()
        self.url = URL(string: "https://rickandmortyapi.com/api/character")
    }

    func getCharacters() async throws -> [CharacterDomain]? {
        guard let request = self.createRequest() else {
            throw HTTPError.createRequest
        }

        guard let response = try await self.client.send(request: request) else {
            return nil
        }

        do {
            let result = try self.decoder.decode(CharacterResponse.self, from: response)
            let domain = result.results.map { CharacterDomain(from: $0) }
            return domain
        } catch {
            print(error.localizedDescription)
            throw HTTPError.JSONParseError
        }
    }
}

extension CharacterRepository {
    func createRequest() -> URLRequest? {
        if let url = url {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            return request
        }

        return nil
    }
}
