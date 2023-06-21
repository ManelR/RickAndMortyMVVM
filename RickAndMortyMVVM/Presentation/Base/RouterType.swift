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
