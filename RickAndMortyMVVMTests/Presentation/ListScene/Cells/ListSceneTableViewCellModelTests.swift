//
//  ListSceneTableViewCellModelTests.swift
//  RickAndMortyMVVMTests
//
//  Created by Manel Roca on 21/6/23.
//

import XCTest
import Combine
@testable import RickAndMortyMVVM

final class ListSceneTableViewCellModelTests: BaseXCTestCase {

    private var sut: ListSceneTableViewCellModel!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        sut = ListSceneTableViewCellModel()
        cancellables = []
    }

    func test_configView_Publish_Correct_titleText() {
        // Given
        let character = CharacterDomain(id: 1, name: "test", species: "test 2", isAlive: true, image: "url")
        var result: String = ""
        let expectation = self.expectation(description: "configView")
        expectation.assertForOverFulfill = false // used to prevent all events from combine
        self.sut.titleText
            .sink {
                if let value = $0,
                   value.count > 0 {
                    result = value
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        // When
        self.sut.configView(from: character)

        waitForExpectations(timeout: 10)

        // Then
        XCTAssertEqual(result, "test")
    }

    func test_configView_Publish_Correct_secondaryText() {
        // Given
        let character = CharacterDomain(id: 1, name: "test", species: "test 2", isAlive: true, image: "url")
        var result: String = ""
        let expectation = self.expectation(description: "configView")
        expectation.assertForOverFulfill = false // used to prevent all events from combine
        self.sut.secondaryText
            .sink {
                if let value = $0,
                   value.count > 0 {
                    result = value
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        // When
        self.sut.configView(from: character)

        waitForExpectations(timeout: 10)

        // Then
        XCTAssertEqual(result, "test 2")
    }

    func test_configView_Publish_Correct_showAlive() {
        // Given
        let character = CharacterDomain(id: 1, name: "test", species: "", isAlive: true, image: "url")
        var result: Bool = false
        let expectation = self.expectation(description: "configView")
        expectation.assertForOverFulfill = false // used to prevent all events from combine
        self.sut.showAlive
            .sink {
                if let value = $0 {
                    result = value
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        // When
        self.sut.configView(from: character)

        waitForExpectations(timeout: 10)

        // Then
        XCTAssertTrue(result)
    }

}
