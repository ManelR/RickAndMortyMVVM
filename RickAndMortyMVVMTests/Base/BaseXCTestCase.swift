//
//  BaseXCTestCase.swift
//  RickAndMortyMVVMTests
//
//  Created by Manel Roca on 21/6/23.
//

import XCTest
@testable import RickAndMortyMVVM

class BaseXCTestCase: XCTestCase {

    override func setUp() {
        super.setUp()
        DIRepository.initialize(MockDIRespositoryContainer())
    }
}
