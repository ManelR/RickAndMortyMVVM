//
//  DownloadImageRepository.swift
//  RickAndMortyMVVM
//
//  Created by Manel Roca on 21/6/23.
//

import Foundation

internal enum DownloadImageRepositoryError: Error {
    case urlError
    case unknown
}

final class DownloadImageRepository: DownloadImageRepositoryType {
    private var session: URLSession?

    func downloadImage(url urlString: String) async throws -> Data {
        guard let url = URL(string: urlString) else {
            throw DownloadImageRepositoryError.urlError
        }

        var urlRequest = URLRequest(url: url)
        // Cache: https://www.w3.org/Protocols/rfc2616/rfc2616-sec13.html#sec13
        urlRequest.cachePolicy = .returnCacheDataElseLoad

        return try await withCheckedThrowingContinuation({ continuation in
            let session = self.getSession()

            session.dataTask(with: urlRequest) { data, _, _ in
                if let data = data {
                    continuation.resume(returning: data)
                    return
                }
                continuation.resume(throwing: DownloadImageRepositoryError.unknown)
            }.resume()
        })
    }

    func hasImageInCache(url urlString: String) -> Bool {
        guard let url = URL(string: urlString) else {
            return false
        }

        let urlRequest = URLRequest(url: url)
        let session = self.getSession()
        return session.configuration.urlCache?.cachedResponse(for: urlRequest) != nil
    }
}

extension DownloadImageRepository {
    // It can be improved with a repository for http calls and reuse it, but for a while I haven't been able to.
    internal func getSession() -> URLSession {
        guard let session = self.session else {
            // Create url session
            let cachesURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
            let diskCacheURL = cachesURL.appendingPathComponent("\(Bundle.main.bundleIdentifier ?? "").remoteresources")
            let cache = URLCache(memoryCapacity: 4_000_000, diskCapacity: 20_000_000, directory: diskCacheURL)

            let configuration = URLSessionConfiguration.default
            configuration.urlCache = cache

            let session = URLSession(configuration: configuration,
                                     delegate: nil,
                                     delegateQueue: nil)
            self.session = session
            return session
        }
        return session
    }
}
