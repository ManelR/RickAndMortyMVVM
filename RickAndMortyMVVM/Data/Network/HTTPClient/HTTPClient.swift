//
//  HTTPClient.swift
//  RickAndMortyMVVM
//
//  Created by Manel Roca on 21/6/23.
//

import Foundation

class HTTPClient: HTTPClientType {
    internal var session: URLSession

    init(session: URLSession) {
        self.session = session
    }

    func send(request: URLRequest) async throws -> Data? {
        var result: (data: Data?, response: URLResponse?)
        do {
            if #available(iOS 15.0, *) {
                result = try await self.makeRequest(request: request)
            } else {
                result = try await self.makeRequestUnderiOS15(request: request)
            }
        } catch {
            try self.handleRequestException(error)
        }

        let status = (result.response as? HTTPURLResponse)?.statusCode ?? 0

        if let httpResponse = result.response as? HTTPURLResponse,
           let date = httpResponse.value(forHTTPHeaderField: "Date") {
            print("\(getName()): RESPONSE \(status) - DATE: \(date)")
        }

        if let data = result.data {
            let body = String(decoding: data, as: UTF8.self)
            print("\(getName()): RESPONSE \(status) - BODY: \(body)")
        }

        guard let httpResponse = result.response as? HTTPURLResponse,
              (200..<300) ~= httpResponse.statusCode else {
            throw exceptionFromStatusCode(status)
        }

        return result.data
    }
}

extension HTTPClient {
    internal func getName() -> String {
        return String(describing: self)
    }

    internal func makeRequestUnderiOS15(request: URLRequest) async throws -> (Data?, URLResponse?) {
        return try await withCheckedThrowingContinuation({ continuation in
            let dataTask = session.dataTask(with: request) { data, response, error in
                guard let error = error else {
                    continuation.resume(returning: (data, response))
                    return
                }
                continuation.resume(throwing: error)
            }

            dataTask.resume()
        })
    }

    @available(iOS 15.0, *)
    internal func makeRequest(request: URLRequest) async throws -> (Data?, URLResponse?) {
        return try await session.data(for: request)
    }

    internal func handleRequestException(_ error: Error?) throws {
        if let error = error as NSError?, error.domain == NSURLErrorDomain {
            if error.code == NSURLErrorNotConnectedToInternet {
                throw HTTPError.noInternet
            } else if error.code == NSURLErrorTimedOut {
                throw HTTPError.timeout
            }
        }
        throw HTTPError.clientError
    }

    internal func exceptionFromStatusCode(_ status: Int) -> Error {
        switch status {
        case 401, 403:
            // Auth error
            return HTTPError.authenticationError
        case 404:
            return HTTPError.notFound
        case 409:
            return HTTPError.conflict
        default:
            // Server error
            return HTTPError.serverError
        }
    }
}
