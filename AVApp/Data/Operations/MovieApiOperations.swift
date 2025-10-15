//
//  MovieApiOperations.swift
//  AVApp
//
//  Created by Alexandre Faltot on 09/10/2025.
//

import Foundation

// MARK: - Operations instances
struct MovieApiOperations {
    /// Gets the operation to get genres from the API
    static var getGenres: MovieApiOperation<EmptyBody, MDBGenreResponse> {
        .init(method: .get,
              endpoint: "/genre/movie/list",
              cachePolicy: .returnCacheDataElseLoad)
    }
    
    ///
    /// Gives the operation to get the popular movies from the Movie DB API
    ///
    /// - Parameter page: The page to fetch
    /// - Returns: The operation for the API
    ///
    static func getPopularMovies(page: Int) -> MovieApiOperation<EmptyBody, MDBMoviesResponse> {
        .init(method: .get,
              endpoint: "/discover/movie",
              queryItems: [.page(page)])
    }

    ///
    /// Gives the operation to get the details of a movie from the Movie DB API
    ///
    /// - Parameter id: The id of the movie
    /// - Returns: The operation for the API
    ///
    static func getMovieDetails(id: Int) -> MovieApiOperation<EmptyBody, MDBMovieDetails> {
        .init(method: .get,
              endpoint: "/movie/\(id)")
    }

    ///
    /// Operation to gets the movie credits from the Movie DB API
    ///
    /// - Parameter id: The id of the movie
    /// - Returns: The operation for the API
    ///
    static func getMovieCredits(id: Int) -> MovieApiOperation<EmptyBody, MDBMovieCredits> {
        .init(method: .get,
              endpoint: "/movie/\(id)/credits")
    }

    ///
    /// Operation to search for movies from the Movie DB API
    ///
    /// - Parameter query: The search query
    /// - Returns: The operation for the API
    ///
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

fileprivate extension MovieApiOperation where Body == EmptyBody {
    convenience init(method: HttpMethod, endpoint: String, queryItems: [URLQueryItem] = [], cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalCacheData) {
        self.init(method: method, endpoint: endpoint, body: EmptyBody(), queryItems: queryItems, cachePolicy: cachePolicy)
    }

    convenience init(method: HttpMethod, endpoint: String, queryItems: [URLQueryItem] = []) {
        self.init(method: method, endpoint: endpoint, body: EmptyBody(), queryItems: queryItems)
    }
}

// MARK: - Headers Extensions
fileprivate extension Dictionary where Key == String, Value == String {

    ///
    /// Gives the default headers for the Movie DB API operations
    ///
    /// - Returns:An array of ``URLQueryItem``
    ///
    static func defaultHeaders() -> [String: String] {
        ["accept": "application/json"]
    }
}

// MARK: - URLQueryItems Extensions
fileprivate extension Collection where Element == URLQueryItem {

    ///
    /// Gives the default  query items for the Movie DB API operations
    ///
    /// - Returns:An array of ``URLQueryItem``
    ///
    static func defaultItems() -> [URLQueryItem] {
        [.language(Locale.current.language.languageCode?.identifier ?? "en"),
         .apiKey(MDBConstants.movieDBApiKey)]
    }
}

fileprivate extension URLQueryItem {
    static func language(_ value: String) -> URLQueryItem { URLQueryItem(name: "language", value: value) }
    static func apiKey(_ value: String?) -> URLQueryItem { URLQueryItem(name: "api_key", value: value) }
    static func page(_ value: Int) -> URLQueryItem { URLQueryItem(name: "page", value: value.description) }
    static func query(_ value: String) -> URLQueryItem { URLQueryItem(name: "query", value: value) }
}
