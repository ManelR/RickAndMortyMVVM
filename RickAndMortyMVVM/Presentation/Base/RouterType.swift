//
//  RouterType.swift
//  RickAndMortyMVVM
//
//  Created by Manel Roca on 21/6/23.
//

import Foundation
import UIKit

protocol RouterType: AnyObject {
    associatedtype RouterEnum: RawRepresentable where RouterEnum.RawValue == String

    var context: UIViewController? { get set }

    func route(
        to route: RouterEnum,
        parameters: Any?...
    )
}

extension RouterType {
    internal func route(next: UIViewController, animated: Bool = true) {
        if let navigation = self.context?.navigationController {
            route(navigation: navigation, next: next, animated: animated)
        } else {
            print("Error: No navigation controller provided")
        }
    }
    
    internal func route(navigation: UINavigationController, next: UIViewController, animated: Bool = true) {
        navigation.pushViewController(next, animated: animated)
    }
}
