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
    weak var router: (any DetailSceneRouterType)?
    var subscriptions = Set<AnyCancellable>()

    // MARK: - OUTPUT IMPLEMENTATION

}

// MARK: - INPUT IMPLEMENTATION

extension DetailSceneViewModel {
    func viewDidLoad() {
        // TODO:
    }
}
