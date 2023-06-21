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

}

// PROTOCOL COMPOSITION
protocol ListSceneViewModelType: ListSceneViewModelInput, ListSceneViewModelOutput {
    var router: (any ListSceneRouterType)? { get set } // weak
}

// DEFAULT MODEL IMPLEMENTATION
class ListSceneViewModel: ListSceneViewModelType {
    weak var router: (any ListSceneRouterType)?
    var subscriptions = Set<AnyCancellable>()

    init(router: (any ListSceneRouterType)? = DIRepository.shared.resolve()) {
        self.router = router
    }

    // MARK: - OUTPUT IMPLEMENTATION

}

// MARK: - INPUT IMPLEMENTATION

extension ListSceneViewModel {
    func viewDidLoad() {
        // TODO:
    }
}
