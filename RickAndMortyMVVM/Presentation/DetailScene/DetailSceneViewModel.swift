//  
//  DetailSceneViewModel.swift
//  RickAndMortyMVVM
//
//  Created by Manel Roca on 21/6/23.
//

import Foundation
import Combine

// INPUT DEFINITION
protocol DetailSceneViewModelInput {
    func viewDidLoad()
    func setCharacter(_ : CharacterDomain)
}

// OUTPUT DEFINITION
protocol DetailSceneViewModelOutput {

}

// PROTOCOL COMPOSITION
protocol DetailSceneViewModelType: DetailSceneViewModelInput, DetailSceneViewModelOutput {
    var router: (any DetailSceneRouterType)? { get set }
}

// DEFAULT MODEL IMPLEMENTATION
class DetailSceneViewModel: DetailSceneViewModelType {
    internal weak var router: (any DetailSceneRouterType)?
    private var subscriptions = Set<AnyCancellable>()
    private var character: CharacterDomain?

    init(router: (any DetailSceneRouterType)? = DIRepository.shared.resolve()) {
        self.router = router
    }

    // MARK: - OUTPUT IMPLEMENTATION

}

// MARK: - INPUT IMPLEMENTATION

extension DetailSceneViewModel {
    func viewDidLoad() {
        // TODO:
        print(character?.name)
    }

    func setCharacter(_ character: CharacterDomain) {
        self.character = character
    }
}
