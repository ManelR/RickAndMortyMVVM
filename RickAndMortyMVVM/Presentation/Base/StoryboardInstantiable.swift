//
//  StoryboardInstantiable.swift
//  RickAndMortyMVVM
//
//  Created by Manel Roca on 21/6/23.
//

import Foundation
import UIKit

public protocol StoryboardInstantiable: AnyObject {
    associatedtype NewViewController
    static var defaultFileName: String { get }
    static func instantiateViewController(_ bundle: Bundle?) -> NewViewController
}

public extension StoryboardInstantiable where Self: UIViewController {
    // EX: LoginSceneViewController -> LoginScene
    static var defaultFileName: String {
        return NSStringFromClass(Self.self)
            .components(separatedBy: ".")
            .last!
            .replacingOccurrences(of: "ViewController", with: "")
    }

    static func instantiateViewController(_ bundle: Bundle? = nil) -> Self {
        let fileName = defaultFileName
        let storyboard = UIStoryboard(name: fileName, bundle: bundle)
        guard let viewController = storyboard.instantiateInitialViewController() as? Self else {
            fatalError("Cannot instantiate initial view controller \(Self.self) from storyboard with name \(fileName)")
        }
        return viewController
    }

    static func instantiateNavigationViewController(_ bundle: Bundle? = nil) -> UINavigationController {
        let fileName = defaultFileName
        let storyboard = UIStoryboard(name: fileName, bundle: bundle)
        guard let viewController = storyboard.instantiateInitialViewController() as? UINavigationController else {
            let message = """
            Cannot instantiate initial view controller \(UINavigationController.self)
            from storyboard with name \(fileName)
            """
            fatalError(message)
        }
        return viewController
    }
}
