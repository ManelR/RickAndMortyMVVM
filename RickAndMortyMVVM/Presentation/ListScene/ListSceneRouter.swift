//  
//  ListSceneRouter.swift
//  RickAndMortyMVVM
//
//  Created by Manel Roca on 21/6/23.
//

import Foundation
import UIKit

protocol ListSceneRouterType: RouterType where RouterEnum == ListSceneRoute {

}

// Routes from Login
enum ListSceneRoute: String {
    case detail
}

final class ListSceneRouter: ListSceneRouterType {
    weak var context: UIViewController?

    func route(to route: ListSceneRoute, parameters: Any?...) {

        switch route {
        case .detail:
            let destination = DetailSceneViewController.instantiateViewController()
            if let character = parameters[0] as? CharacterDomain {
                destination.setCharacter(character)
            }
            self.route(next: destination)
        }
    }
}
