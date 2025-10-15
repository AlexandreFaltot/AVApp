//
//  ListRepository.swift
//  AVApp
//
//  Created by Alexandre Faltot on 09/10/2025.
//

protocol MovieRepositoryProtocol {
    ///
    /// Gets the popular movies from the Movie API
    ///
    /// - Parameter page: The page to fetch
    /// - Returns: The API response
    ///
    func getPopularMovies(page: Int) async throws -> MDBMoviesResponse

    ///
    /// Gets a movie details from the Movie API
    ///
    /// - Parameter id: The id of the movie
    /// - Returns: The API response
    ///
    func getMovieDetails(id: Int) async throws -> MDBMovieDetails

    ///
    /// Gets a movie credits from the Movie API
    ///
    /// - Parameter id: The id of the movie
    /// - Returns: The API response
    ///
    func getMovieCredits(id: Int) async throws -> MDBMovieCredits

    ///
    /// Gets a list of movies from search query with the Movie API
    ///
    /// - Parameter query: The search query
    /// - Returns: The API response
    ///
    func searchMovies(query: String) async throws -> MDBMoviesResponse
}

class MovieRepository: MovieRepositoryProtocol {
    private let restClient: any RestClientProtocol

    init(restClient: RestClientProtocol = Module.shared.resolve()) {
        self.restClient = restClient
    }

    func getPopularMovies(page: Int) async throws -> MDBMoviesResponse {
        try await restClient.request(operation: MovieApiOperations.getPopularMovies(page: page))
    }

    func getMovieDetails(id: Int) async throws -> MDBMovieDetails {
        try await restClient.request(operation: MovieApiOperations.getMovieDetails(id: id))
    }

    func getMovieCredits(id: Int) async throws -> MDBMovieCredits {
        try await restClient.request(operation: MovieApiOperations.getMovieCredits(id: id))
    }

    func searchMovies(query: String) async throws -> MDBMoviesResponse {
        try await restClient.request(operation: MovieApiOperations.searchMovies(query: query))
    }
}
