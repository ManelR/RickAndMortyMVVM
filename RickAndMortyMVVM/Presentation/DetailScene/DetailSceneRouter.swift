//  
//  DetailSceneRouter.swift
//  RickAndMortyMVVM
//
//  Created by Manel Roca on 21/6/23.
//

import Foundation
import UIKit

protocol DetailSceneRouterType: RouterType {

}

// Routes from Login
enum DetailSceneRoute: String {
    case foo
}

class DetailSceneRouter: DetailSceneRouterType {
    weak var context: UIViewController?

    func route(to route: DetailSceneRoute, parameters: Any?...) {

        switch route {
        case .foo:
            // TODO:
            print("Go to foo")
        }
    }
}
