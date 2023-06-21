//
//  HTTPError.swift
//  RickAndMortyMVVM
//
//  Created by Manel Roca on 21/6/23.
//

import Foundation

public enum HTTPError: Error, LocalizedError, CustomNSError, Equatable {
    // Server Error
    case authenticationError
    case serverError
    // Client Error
    case clientError
    case conflict
    case notFound
    case noInternet
    case timeout
    // Other
    case JSONParseError
    case responseModelNotConformsDecodable
    case createRequest
    case unknownError

    public var errorDescription: String? {
        switch self {
        default:
            return "\(self)"
        }
    }

    public var errorUserInfo: [String: Any] {
        return [NSLocalizedDescriptionKey: self.errorDescription ?? ""]
    }
}
