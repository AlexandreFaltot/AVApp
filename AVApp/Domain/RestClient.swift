//
//  RestClient.swift
//  AVApp
//
//  Created by Alexandre Faltot on 09/10/2025.
//

import Foundation
import OSLog

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case update = "UPDATE"
    case delete = "DELETE"
}

enum OperationError: Error {
    case malformedUrl
}

protocol RestClientProtocol {
    func request<Body: Encodable, Response: Decodable>(operation: RestApiOperation<Body, Response>) async throws -> Response
}

class RestClient: RestClientProtocol {
    private let urlSession: URLSession

    init(urlSession: URLSession = Module.shared.resolve()) {
        self.urlSession = urlSession
    }

    func request<Body: Encodable, Response: Decodable>(operation: RestApiOperation<Body, Response>) async throws -> Response {
        let urlRequest = try operation.buildUrlRequest()
        Logger.debug("[RestClient] Making request \(urlRequest.httpMethod?.description ?? "") \(urlRequest.url?.absoluteString ?? "")")
        if let headers = urlRequest.allHTTPHeaderFields {
            Logger.debug("[RestClient] with headers \(headers.description)")
        }
        if let body = urlRequest.httpBody {
            Logger.debug("[RestClient] with body: \(String(data: body, encoding: .utf8) ?? "")")
        }

        do {
            let (data, _) = try await urlSession.data(for: urlRequest)
            Logger.debug("[RestClient] 🟢 Received response from \(urlRequest.httpMethod?.description ?? "") \(urlRequest.url?.absoluteString ?? "")")
            Logger.debug("[RestClient] 🟢 Response received: \(String(data: data, encoding: .utf8) ?? "")")
            let decodedData = try JSONDecoder().decode(Response.self, from: data)
            return decodedData
        } catch {
            Logger.debug("[RestClient] 🔴 Error with request \(urlRequest.httpMethod?.description ?? "") \(urlRequest.url?.absoluteString ?? "")")
            Logger.debug("[RestClient] 🔴 Error received: \(error)")
            throw error
        }
    }
}
