//
//  MovieApiOperations.swift
//  AVApp
//
//  Created by Alexandre Faltot on 09/10/2025.
//

import Foundation

// MARK: - Operations instances
struct MovieApiOperations {
    static var getGenres: MovieApiOperation<EmptyBody, MDBGenreResponse> {
        .init(method: .get,
              endpoint: "/genre/movie/list",
              cachePolicy: .returnCacheDataElseLoad)
    }

    static func getPopularMovies(page: Int) -> MovieApiOperation<EmptyBody, MDBMoviesResponse> {
        .init(method: .get,
              endpoint: "/discover/movie",
              queryItems: [.page(page)])
    }

    static func getMovieDetails(id: Int) -> MovieApiOperation<EmptyBody, MDBMovieDetails> {
        .init(method: .get,
              endpoint: "/movie/\(id)")
    }

    static func getMovieCredits(id: Int) -> MovieApiOperation<EmptyBody, MDBMovieCredits> {
        .init(method: .get,
              endpoint: "/movie/\(id)/credits")
    }

    static func searchMovies(query: String) -> MovieApiOperation<EmptyBody, MDBMoviesResponse> {
        .init(method: .get,
              endpoint: "/search/movie",
              queryItems: [.query(query)])
    }
}

// MARK: - MovieApiOperation
class MovieApiOperation<Body: Encodable, Response: Decodable>: RestApiOperation<Body, Response> {
    fileprivate init(method: HttpMethod, endpoint: String, body: Body, queryItems: [URLQueryItem] = [], cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalCacheData) {
        super.init(method: method,
                   baseUrl: MDBConstants.baseUrl,
                   endpoint: endpoint,
                   queryItems: .defaultItems() + queryItems,
                   headers: .defaultHeaders(),
                   cachePolicy: cachePolicy,
                   body: body)
    }
}

extension MovieApiOperation where Body == EmptyBody {
    convenience init(method: HttpMethod, endpoint: String, queryItems: [URLQueryItem] = [], cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalCacheData) {
        self.init(method: method, endpoint: endpoint, body: EmptyBody(), queryItems: queryItems, cachePolicy: cachePolicy)
    }
}

// MARK: - Extensions
fileprivate extension Collection where Element == URLQueryItem {
    static func defaultItems() -> [URLQueryItem] {
        [.language(Locale.current.language.languageCode?.identifier ?? "en"),
         .apiKey(MDBConstants.movieDBApiKey)]
    }
}

fileprivate extension Dictionary where Key == String, Value == String {
    static func defaultHeaders() -> [String: String] {
        ["accept": "application/json"]
    }
}

fileprivate extension MovieApiOperation where Body == EmptyBody {
    convenience init(method: HttpMethod, endpoint: String, queryItems: [URLQueryItem] = []) {
        self.init(method: method, endpoint: endpoint, body: EmptyBody(), queryItems: queryItems)
    }
}

fileprivate extension URLQueryItem {
    static func language(_ value: String) -> URLQueryItem { URLQueryItem(name: "language", value: value) }
    static func apiKey(_ value: String?) -> URLQueryItem { URLQueryItem(name: "api_key", value: value) }
    static func page(_ value: Int) -> URLQueryItem { URLQueryItem(name: "page", value: value.description) }
    static func query(_ value: String) -> URLQueryItem { URLQueryItem(name: "query", value: value) }
}
