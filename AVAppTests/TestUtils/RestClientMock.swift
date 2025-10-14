//
//  RestClientMock.swift
//  AVApp
//
//  Created by Alexandre Faltot on 15/10/2025.
//

import Foundation
@testable import AVApp

final class RestClientMock: RestClientProtocol {
    var requestCallCount = 0
    var shouldThrowError: Bool
    var mockResponse: (any Decodable)?

    init(shouldThrowError: Bool = false, mockResponse: (any Decodable)? = nil) {
        self.shouldThrowError = shouldThrowError
        self.mockResponse = mockResponse
    }

    func request<Body: Encodable, Response: Decodable>(operation: RestApiOperation<Body, Response>) async throws -> Response {
        requestCallCount += 1
        guard !shouldThrowError,
              let response = mockResponse as? Response else {
            throw MockError.sample
        }

        return response
    }
}
