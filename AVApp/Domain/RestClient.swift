//
//  RestClient.swift
//  AVApp
//
//  Created by Alexandre Faltot on 09/10/2025.
//

import Foundation

protocol RestClientProtocol {
    func request<Body: Encodable, Response: Decodable>(operation: RestApiOperation<Body, Response>) async throws -> Response
}

class RestClient: RestClientProtocol {
    private let urlSession: URLSession

    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    func request<Body: Encodable, Response: Decodable>(operation: RestApiOperation<Body, Response>) async throws -> Response {
        let (data, _) = try await urlSession.data(for: try operation.buildUrlRequest())
        let decodedData = try JSONDecoder().decode(Response.self, from: data)
        return decodedData
    }
}


enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case update = "UPDATE"
    case delete = "DELETE"
}

struct EmptyBody: Codable {}

struct MyApiResponse: Decodable {
    var messages: [String]
}


struct MyApiDao: Encodable {
    var stuff: String
}

enum MyApiOperations {
    static var getOperation: MyApiOperation<EmptyBody, MyApiResponse> {
        .init(
            method: .get,
            endpoint: "/messages"
        )
    }

    static var postOperation: MyApiOperation<MyApiDao, MyApiResponse> {
        .init(method: .get,
              endpoint: "/message",
              body: MyApiDao(stuff: ""))
    }
}

class MyApiOperation<Body: Encodable, Response: Decodable>: RestApiOperation<Body, Response> {
    fileprivate init(method: HttpMethod, endpoint: String, queryItems: [URLQueryItem] = [], body: Body) {
        super.init(method: method,
                   baseUrl: "https://some-url.com",
                   endpoint: endpoint,
                   queryItems: queryItems,
                   headers: ["Content-type": "application/json"],
                   body: body)
    }
}

fileprivate extension MyApiOperation where Body == EmptyBody {
    convenience init(method: HttpMethod, endpoint: String, queryItems: [URLQueryItem] = []) {
        self.init(method: method, endpoint: endpoint, queryItems: queryItems, body: EmptyBody())
    }
}

class RestApiOperation<Body: Encodable, Response: Decodable> {
    private var method: HttpMethod
    private var queryItems: [URLQueryItem]
    private var headers: [String: String]
    private var baseUrl: String
    private var endpoint: String
    private var body: Body

    init(method: HttpMethod,
         baseUrl: String,
         endpoint: String,
         queryItems: [URLQueryItem],
         headers: [String : String],
         body: Body,
    ) {
        self.method = method
        self.queryItems = queryItems
        self.headers = headers
        self.baseUrl = baseUrl
        self.endpoint = endpoint
        self.body = body
    }

    func buildUrlRequest() throws -> URLRequest {
        // Build url
        guard var url = URL(string: baseUrl + endpoint) else {
            throw OperationError.malformedUrl
        }

        url = url.appending(queryItems: queryItems)

        // Build request
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = String(describing: method)
        urlRequest.httpBody = body is EmptyBody ? nil : try JSONEncoder().encode(body)
        urlRequest.allHTTPHeaderFields = headers

        return urlRequest
    }
}

enum OperationError: Error {
    case malformedUrl
}
