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
    func filterList(_ filter: String)
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
    private var filter: String?
    private var requestTask: Task<Void, Error>?

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

    func filterList(_ filter: String) {
        self.filter = filter
        self.requestDataAndNotifyView(delay: 500_000_000)
    }
}

// MARK: - PRIVATE METHODS
extension ListSceneViewModel {
    func requestDataAndNotifyView(delay nanoseconds: Int? = 0) {
        if let task = self.requestTask {
            task.cancel()
        }

        self.requestTask = Task {
            do {
                if let nanoseconds = nanoseconds {
                    try await Task.sleep(nanoseconds: UInt64(nanoseconds))
                }
                try Task.checkCancellation()
                let response = try await self.characterRepository.getCharacters(filter: self.filter)
                try Task.checkCancellation()
                await MainActor.run {
                    self.pCharacters = response
                }
            } catch {
                // TODO: Error
            }
        }
    }
}
