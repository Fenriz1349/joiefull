//
//  ClothingServiceTests.swift
//  joiefullTests
//
//  Created by Julien Cotte on 02/02/2026.
//

import XCTest
@testable import joiefull

final class ClothingServiceTests: XCTestCase {

    func test_fetchClothes_whenHTTP200_returnsDecodedItems() async throws {
        let json = """
        [
          {
            "id": 0,
            "picture": { "url": "https://example.com/1.jpg", "description": "desc" },
            "name": "Sac",
            "category": "ACCESSORIES",
            "likes": 10,
            "price": 69.99,
            "original_price": 69.99
          }
        ]
        """.data(using: .utf8)!

        let session = makeSession(
            data: json,
            statusCode: 200
        )

        let sut = ClothingService(url: URL(string: "https://example.com/clothes.json"), session: session)

        let items = try await sut.fetchClothes()
        XCTAssertEqual(items.count, 1)
    }

    func test_fetchClothes_whenHTTPFails_throwsHttpStatus() async {
        let session = makeSession(data: Data(), statusCode: 500)
        let sut = ClothingService(url: URL(string: "https://example.com/clothes.json"), session: session)

        do {
            _ = try await sut.fetchClothes()
            XCTFail("Expected error")
        } catch let error as ClothingServiceError {
            XCTAssertEqual(error, .httpStatus(500))
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    // MARK: - Test plumbing

    private func makeSession(data: Data, statusCode: Int) -> URLSession {
        URLProtocolStub.stub = .init(data: data, statusCode: statusCode)

        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolStub.self]
        return URLSession(configuration: config)
    }
}

private final class URLProtocolStub: URLProtocol {

    struct Stub {
        let data: Data
        let statusCode: Int
    }

    static var stub: Stub!

    override class func canInit(with request: URLRequest) -> Bool { true }
    override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }

    override func startLoading() {
        let response = HTTPURLResponse(
            url: request.url!,
            statusCode: Self.stub.statusCode,
            httpVersion: nil,
            headerFields: nil
        )!

        client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        client?.urlProtocol(self, didLoad: Self.stub.data)
        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() { }
}

