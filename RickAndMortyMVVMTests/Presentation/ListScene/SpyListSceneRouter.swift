//
//  SpyListSceneRouter.swift
//  RickAndMortyMVVMTests
//
//  Created by Manel Roca on 22/6/23.
//

import Foundation
import UIKit
@testable import RickAndMortyMVVM

final class SpyListSceneRouter: ListSceneRouterType {
    var context: UIViewController?
    var route: ListSceneRoute?
    var countRoute: Int = 0

    nonisolated init() {
        
    }

    func route(to route: ListSceneRoute, parameters: Any?...) {
        self.route = route
        self.countRoute += 1
    }
}
