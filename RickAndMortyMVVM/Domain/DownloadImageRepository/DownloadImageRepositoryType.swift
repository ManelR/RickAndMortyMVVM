//
//  DownloadImageRepository.swift
//  RickAndMortyMVVM
//
//  Created by Manel Roca on 21/6/23.
//

import Foundation

protocol DownloadImageRepositoryType {
    func downloadImage(url: String) async throws -> Data
    func hasImageInCache(url: String) -> Bool
}
