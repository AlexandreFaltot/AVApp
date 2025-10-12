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
    static let shared: RestClient = RestClient()

    private let urlSession: URLSession

    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    func request<Body: Encodable, Response: Decodable>(operation: RestApiOperation<Body, Response>) async throws -> Response {
        
        let urlRequest = try operation.buildUrlRequest()
        print("[RestClient] Making request \(urlRequest.httpMethod?.description ?? "") \(urlRequest.url?.absoluteString ?? "")")
        if let headers = urlRequest.allHTTPHeaderFields {
            print("[RestClient] with headers \(headers.description)")
        }
        if let body = urlRequest.httpBody {
            print("[RestClient] with body: \(String(data: body, encoding: .utf8) ?? "")")
        }

        do {
            let (data, _) = try await urlSession.data(for: urlRequest)
            print("[RestClient] 🟢 Received response from \(urlRequest.httpMethod?.description ?? "") \(urlRequest.url?.absoluteString ?? "")")
            print("[RestClient] 🟢 Response received: \(String(data: data, encoding: .utf8) ?? "")")
            let decodedData = try JSONDecoder().decode(Response.self, from: data)
            return decodedData
        } catch {
            print("[RestClient] 🔴 Error with request \(urlRequest.httpMethod?.description ?? "") \(urlRequest.url?.absoluteString ?? "")")
            print("[RestClient] 🔴 Error received: \(error)")
            throw error
        }
    }
}


class NetworkCacheManager {
    static let shared = NetworkCacheManager()

    private init() {
        configureCache()
    }

    func configureCache() {
        // Configure URLCache with custom memory and disk capacity
        let memoryCapacity = 50 * 1024 * 1024  // 50 MB
        let diskCapacity = 100 * 1024 * 1024   // 100 MB

        URLCache.shared = URLCache(
            memoryCapacity: memoryCapacity,
            diskCapacity: diskCapacity,
            directory: nil
        )
    }

    func clearCache() {
        URLCache.shared.removeAllCachedResponses()
    }

    func getCacheSize() -> (memory: Int, disk: Int) {
        return (
            memory: URLCache.shared.currentMemoryUsage,
            disk: URLCache.shared.currentDiskUsage
        )
    }
}
