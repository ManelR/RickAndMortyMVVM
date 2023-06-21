//  
//  ListSceneViewModel.swift
//  RickAndMortyMVVM
//
//  Created by Manel Roca on 21/6/23.
//

import Foundation
import Combine

// INPUT DEFINITION
protocol ListSceneViewModelInput {
    func viewDidLoad()
}

// OUTPUT DEFINITION
protocol ListSceneViewModelOutput {
    var characters: Published<[CharacterDomain]?>.Publisher { get }
}

// PROTOCOL COMPOSITION
protocol ListSceneViewModelType: ListSceneViewModelInput, ListSceneViewModelOutput {
    var router: (any ListSceneRouterType)? { get set } // weak
}

// DEFAULT MODEL IMPLEMENTATION
final class ListSceneViewModel: ListSceneViewModelType {
    internal weak var router: (any ListSceneRouterType)?
    private var characterRepository: CharacterRepositoryType
    var subscriptions = Set<AnyCancellable>()

    // MARK: - OUTPUT IMPLEMENTATION
    @Published var vCharacters: [CharacterDomain]?
    var characters: Published<[CharacterDomain]?>.Publisher { $vCharacters }

    init(router: (any ListSceneRouterType)? = DIRepository.shared.resolve(),
         characterRepository: CharacterRepositoryType = DIRepository.shared.resolve()) {
        self.router = router
        self.characterRepository = characterRepository
    }
}

// MARK: - INPUT IMPLEMENTATION
extension ListSceneViewModel {
    func viewDidLoad() {
        self.requestDataAndNotifyView()
    }
}

// MARK: - PRIVATE METHODS
extension ListSceneViewModel {
    func requestDataAndNotifyView() {
        Task {
            do {
                let response = try await self.characterRepository.getCharacters()
                await MainActor.run {
                    self.vCharacters = response
                }
            } catch {
                // TODO: Error
            }
        }
    }
}
