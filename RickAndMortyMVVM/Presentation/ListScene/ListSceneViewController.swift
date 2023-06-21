//  
//  ListSceneViewController.swift
//  RickAndMortyMVVM
//
//  Created by Manel Roca on 21/6/23.
//

import Foundation
import UIKit
import Combine

class ListSceneViewController: UIViewController, StoryboardInstantiable {
    // MARK: - IBOUTLETS

    // MARK: - VARs
    private var subscriptions: Set<AnyCancellable> = []

    internal var router: any ListSceneRouterType = DIRepository.shared.resolve()
    internal var viewModel: ListSceneViewModelType = DIRepository.shared.resolve()

    // MARK: - Init
    init() {
        super.init(nibName: nil, bundle: nil)
        self.linkModelAndRouter()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.linkModelAndRouter()
    }

    // MARK: - CLASS IMPLEMENTATION
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bind()
        self.viewModel.viewDidLoad()
        let repository: CharacterRepositoryType = DIRepository.shared.resolve()
        Task {
            do {
                let result = try await repository.getCharacters()
                print(result)
            } catch {
                print(error)
            }

        }
    }

    func bind() {
        subscriptions = [
            // TODO:
            // Ex: self.viewModel.backgroundColor.assign(to: \.backgroundColor, on: self.view)
        ]
    }

    // MARK: - ACTIONS

}

extension ListSceneViewController {
    private func linkModelAndRouter() {
        self.router.context = self
        self.viewModel.router = self.router
    }
}
