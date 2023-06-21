//  
//  ListSceneRouter.swift
//  RickAndMortyMVVM
//
//  Created by Manel Roca on 21/6/23.
//

import Foundation
import UIKit

protocol ListSceneRouterType: RouterType {

}

// Routes from Login
enum ListSceneRoute: String {
    case foo
}

class ListSceneRouter: ListSceneRouterType {
    weak var context: UIViewController?

    func route(to route: ListSceneRoute, parameters: Any?...) {

        switch route {
        case .foo:
            // TODO:
            print("Go to foo")
        }
    }
}
