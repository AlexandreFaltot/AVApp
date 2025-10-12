//
//  MovieApiOperations.swift
//  AVApp
//
//  Created by Alexandre Faltot on 09/10/2025.
//

import Foundation

struct MovieApiOperations {
    static func getPopularMovies(page: Int) -> MovieApiOperation<EmptyBody, MDBMovieResponse> {
        .init(method: .get,
              endpoint: "/discover/movie",
              queryItems: [.page(page)])
    }

    static var getGenres: MovieApiOperation<EmptyBody, MDBGenreResponse> {
        .init(method: .get,
              endpoint: "/genre/movie/list")
    }
}

class MovieApiOperation<Body: Encodable, Response: Decodable>: RestApiOperation<Body, Response> {
    fileprivate init(method: HttpMethod, endpoint: String, body: Body, queryItems: [URLQueryItem] = [], cachePolicy: URLRequest.CachePolicy = .returnCacheDataElseLoad) {
        super.init(method: method,
                   baseUrl: "https://api.themoviedb.org/3",
                   endpoint: endpoint,
                   queryItems: .defaultItems() + queryItems,
                   headers: .defaultHeaders(),
                   cachePolicy: cachePolicy,
                   body: body)
    }
}

fileprivate extension Collection where Element == URLQueryItem {
    static func defaultItems() -> [URLQueryItem] {
        [.language(Locale.current.identifier),
         .apiKey(Constants.movieDBApiKey)]
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

extension URLQueryItem {
    static func language(_ value: String) -> URLQueryItem { URLQueryItem(name: "language", value: value) }
    static func apiKey(_ value: String) -> URLQueryItem { URLQueryItem(name: "api_key", value: value) }
    static func page(_ value: Int) -> URLQueryItem { URLQueryItem(name: "page", value: value.description) }
}
