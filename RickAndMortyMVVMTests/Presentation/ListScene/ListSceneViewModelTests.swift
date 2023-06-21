//
//  ListSceneViewModelTests.swift
//  RickAndMortyMVVMTests
//
//  Created by Manel Roca on 21/6/23.
//

import XCTest
import Combine
@testable import RickAndMortyMVVM

final class ListSceneViewModelTests: BaseXCTestCase {


    private var sut: ListSceneViewModel!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        sut = ListSceneViewModel()
        cancellables = []
    }

    func test_viewDidLoad_RequestData_And_Notify_View() {
        // Given
        var result: [CharacterDomain] = []
        let expectation = self.expectation(description: "viewDidLoad")
        expectation.assertForOverFulfill = false // used to prevent all events from combine
        self.sut.characters
            .sink {
                if let value = $0,
                   value.count > 0 {
                    result = value
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        // When
        self.sut.viewDidLoad()

        waitForExpectations(timeout: 10)

        // Then
        XCTAssertNotNil(result)
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result[0].name, "Rick Sanchez")
        XCTAssertEqual(result[1].name, "Morty Smith")
    }

    func test_viewDidLoad_RequestData_And_Notify_View_OnMainThread() {
        // Given
        let expectation = self.expectation(description: "viewDidLoad")
        expectation.assertForOverFulfill = false
        self.sut.characters
            .sink { _ in
                XCTAssertTrue(Thread.isMainThread)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        // When
        self.sut.viewDidLoad()

        waitForExpectations(timeout: 10)
    }
}
