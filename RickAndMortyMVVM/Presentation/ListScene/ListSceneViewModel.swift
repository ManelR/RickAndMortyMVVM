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
    func didSelectRow(_ index: Int)
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
    @Published var pCharacters: [CharacterDomain]?
    var characters: Published<[CharacterDomain]?>.Publisher { $pCharacters }

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

    func didSelectRow(_ index: Int) {
        // Move to details
        if pCharacters?.count ?? 0 > index,
           let character = pCharacters?[index] {
            self.router?.route(to: .detail, parameters: character)
        } else {
            self.router?.route(to: .detail, parameters: nil)
        }
    }
}

// MARK: - PRIVATE METHODS
extension ListSceneViewModel {
    func requestDataAndNotifyView() {
        Task {
            do {
                let response = try await self.characterRepository.getCharacters()
                await MainActor.run {
                    self.pCharacters = response
                }
            } catch {
                // TODO: Error
            }
        }
    }
}
