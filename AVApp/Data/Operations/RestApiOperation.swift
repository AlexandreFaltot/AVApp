//
//  RestApiOperation.swift
//  AVApp
//
//  Created by Alexandre Faltot on 09/10/2025.
//

import Foundation

class RestApiOperation<Body: Encodable, Response: Decodable> {
    private var method: HttpMethod
    private var queryItems: [URLQueryItem]
    private var headers: [String: String]
    private var baseUrl: String
    private var endpoint: String
    private var cachePolicy: URLRequest.CachePolicy
    private var body: Body

    init(method: HttpMethod,
         baseUrl: String,
         endpoint: String,
         queryItems: [URLQueryItem],
         headers: [String: String],
         cachePolicy: URLRequest.CachePolicy,
         body: Body,
    ) {
        self.method = method
        self.queryItems = queryItems
        self.headers = headers
        self.baseUrl = baseUrl
        self.endpoint = endpoint
        self.cachePolicy = cachePolicy
        self.body = body
    }
    
    ///
    /// Builds a ``URLRequest`` based on the information contained in the object
    ///
    /// - Returns: A ``URLRequest`` object represented by the object. Throws an error in case of wrong information
    ///
    func buildUrlRequest() throws -> URLRequest {
        // Build url
        guard var url = URL(string: baseUrl + endpoint) else {
            throw OperationError.malformedUrl
        }

        url = url.appending(queryItems: queryItems)

        // Build request
        var urlRequest = URLRequest(url: url)
        urlRequest.cachePolicy = cachePolicy
        urlRequest.httpMethod = String(describing: method)
        urlRequest.httpBody = body is EmptyBody ? nil : try JSONEncoder().encode(body)
        urlRequest.allHTTPHeaderFields = headers

        return urlRequest
    }
}
