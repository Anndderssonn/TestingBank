//
//  URLSessionNetworkClientTests.swift
//  TestingBankTests
//
//  Created by Andersson on 4/03/26.
//

import XCTest
@testable import TestingBank

@MainActor
final class URLSessionNetworkClientTests: XCTestCase {
    var sut: URLSessionNetworkClient!
    var urlSession: URLSession!
    
    override func setUp() {
        super.setUp()
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        urlSession = URLSession(configuration: config)
        sut = URLSessionNetworkClient(session: urlSession)
    }
    
    override func tearDown() {
        MockURLProtocol.requestHandler = nil
        urlSession = nil
        sut = nil
        super.tearDown()
    }
    
    func test_whenInvalidURL_throwsInvalidURL() async {
        let request = NetworkRequest(url: "", method: .GET)
        do {
            _ = try await sut.perform(request)
            XCTFail("Error was expected, but none was thrown")
        } catch let error as NetworkError {
            XCTAssertEqual(error, .invalidURL)
        } catch {
            XCTFail("NetworkError was expected, but got: \(error)")
        }
    }
    
    func test_whenResponseIs200_returnsData() async throws {
        let expectedData = "response".data(using: .utf8)!
        MockURLProtocol.requestHandler = { _ in
            let response = HTTPURLResponse(
                url: URL(string: "https://test.com")!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, expectedData)
        }
        let request = NetworkRequest(url: "https://test.com", method: .GET)
        let result = try await sut.perform(request)
        XCTAssertEqual(result, expectedData)
    }
    
    func test_whenResponseIs401_throwsInvalidResponse() async {
        MockURLProtocol.requestHandler = { _ in
            let response = HTTPURLResponse(
                url: URL(string: "https://test.com")!,
                statusCode: 401,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, Data())
        }
        let request = NetworkRequest(url: "https://test.com", method: .GET)
        do {
            _ = try await sut.perform(request)
            XCTFail("Error was expected, but none was thrown")
        } catch let error as NetworkError {
            XCTAssertEqual(error, .invalidResponse)
        } catch {
            XCTFail("NetworkError was expected, but got: \(error)")
        }
    }
    
    func test_whenResponseIs500_throwsInvalidResponse() async {
        MockURLProtocol.requestHandler = { _ in
            let response = HTTPURLResponse(
                url: URL(string: "https://test.com")!,
                statusCode: 500,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, Data())
        }
        let request = NetworkRequest(url: "https://test.com", method: .GET)
        do {
            _ = try await sut.perform(request)
            XCTFail("Error was expected, but none was thrown")
        } catch let error as NetworkError {
            XCTAssertEqual(error, .invalidResponse)
        } catch {
            XCTFail("NetworkError was expected, but got: \(error)")
        }
    }
    
    func test_whenHeadersProvided_sendsThemInRequest() async throws {
        var capturedRequest: URLRequest?
        MockURLProtocol.requestHandler = { request in
            capturedRequest = request
            let response = HTTPURLResponse(
                url: URL(string: "https://test.com")!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, Data())
        }
        let request = NetworkRequest(
            url: "https://test.com",
            method: .GET,
            headers: ["Accept": "application/json"]
        )
        _ = try await sut.perform(request)
        XCTAssertEqual(capturedRequest?.value(forHTTPHeaderField: "Accept"), "application/json")
    }
}
