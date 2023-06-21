//
//  HTTPClientTests.swift
//  RickAndMortyMVVMTests
//
//  Created by Manel Roca on 21/6/23.
//

import XCTest
@testable import RickAndMortyMVVM

final class HTTPClientTests: BaseXCTestCase {

    private var sut: HTTPClient!

    override func setUp() {
        super.setUp()
        let session = createMockSession()
        sut = HTTPClient(session: session)
    }

    private func createMockSession() -> URLSession {
        let configuration: URLSessionConfiguration = .ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        return URLSession(configuration: configuration)
    }

    // MARK: Success
    func test_Send_Request_200_Assert_Data_Is_Equal() async {
        // Given
        let json =
                  """
                  {
                     "name" : "Manel",
                     "age" : 28
                  }
                  """
        let data = json.data(using: .utf8)!
        let url = URL(string: "https://mroca.me/test")!

        MockURLProtocol.error = nil
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: url,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: ["Content-Type": "application/json"])!
            return (response, data)
        }

        // When
        let urlRequest = URLRequest(url: url)
        do {
            let result = try await self.sut.send(request: urlRequest)
            // Then
            XCTAssertEqual(result, data)
        } catch {
            XCTFail("This request should not fail")
        }
    }

    func test_Send_Request_201_Assert_Success() async {
        // Given
        let json = ""
        let data = json.data(using: .utf8)!
        let url = URL(string: "https://mroca.me/test")!

        MockURLProtocol.error = nil
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: url,
                                           statusCode: 201,
                                           httpVersion: nil,
                                           headerFields: ["Content-Type": "application/json"])!
            return (response, data)
        }


        let urlRequest = URLRequest(url: url)
        do {
            // When
            let result = try await self.sut.send(request: urlRequest)
            // Then
            XCTAssertNotNil(result)
        } catch {
            XCTFail("This request should not fail")
        }
    }

    func test_Send_Request_204_Assert_Success() async {
        // Given
        let json = ""
        let data = json.data(using: .utf8)!
        let url = URL(string: "https://mroca.me/test")!

        MockURLProtocol.error = nil
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: url,
                                           statusCode: 204,
                                           httpVersion: nil,
                                           headerFields: ["Content-Type": "application/json"])!
            return (response, data)
        }


        let urlRequest = URLRequest(url: url)
        do {
            // When
            let result = try await self.sut.send(request: urlRequest)
            // Then
            XCTAssertNotNil(result)
        } catch {
            XCTFail("This request should not fail")
        }
    }

    // MARK: Server Errors
    private func checkHTTPStatusCodeError(statusCode: Int, error checkError: HTTPError) async {
        // Given
        let url = URL(string: "https://mroca.me/test")!

        MockURLProtocol.error = nil
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: url,
                                           statusCode: statusCode,
                                           httpVersion: nil,
                                           headerFields: nil)!
            return (response, Data())
        }

        // When
        let urlRequest = URLRequest(url: url)
        do {
            _ = try await self.sut.send(request: urlRequest)
            XCTFail("This request must fail")
        } catch {
            // Then
            XCTAssertEqual(error as! HTTPError, checkError)
        }
    }

    func test_Send_Request_401_Assert_Throws_Authentication_Error() async {
        await self.checkHTTPStatusCodeError(statusCode: 401, error: .authenticationError)
    }

    func test_Send_Request_403_Assert_Throws_Authentication_Error() async {
        await self.checkHTTPStatusCodeError(statusCode: 403, error: .authenticationError)
    }

    func test_Send_Request_404_Assert_Throws_NotFound_Error() async {
        await self.checkHTTPStatusCodeError(statusCode: 404, error: .notFound)
    }

    func test_Send_Request_409_Assert_Throws_Confict_Error() async {
        await self.checkHTTPStatusCodeError(statusCode: 409, error: .conflict)
    }

    // MARK: Client Errors
    func test_Send_Request_No_Internet_Throws_NoInternet_Error() async {
        // Given
        let url = URL(string: "https://mroca.me/test")!

        MockURLProtocol.error = NSError(domain: NSURLErrorDomain,
                                        code: NSURLErrorNotConnectedToInternet)
        MockURLProtocol.requestHandler = nil

        // When
        let urlRequest = URLRequest(url: url)
        do {
            _ = try await self.sut.send(request: urlRequest)
            XCTFail("This request must fail")
        } catch {
            // Then
            XCTAssertEqual(error as! HTTPError, HTTPError.noInternet)
        }
    }

    func test_Send_Request_Timeout_Throws_Timeout_Error() async {
        // Given
        let url = URL(string: "https://mroca.me/test")!

        MockURLProtocol.error = NSError(domain: NSURLErrorDomain,
                                        code: NSURLErrorTimedOut)
        MockURLProtocol.requestHandler = nil

        // When
        let urlRequest = URLRequest(url: url)
        do {
            _ = try await self.sut.send(request: urlRequest)
            XCTFail("This request must fail")
        } catch {
            // Then
            XCTAssertEqual(error as! HTTPError, HTTPError.timeout)
        }
    }
}

