//
//  ListRepository.swift
//  AVApp
//
//  Created by Alexandre Faltot on 09/10/2025.
//

protocol MovieRepositoryProtocol {
    func getPopularMovies(page: Int) async throws -> MDBMoviesResponse
    func getMovieDetails(id: Int) async throws -> MDBMovieDetails
    func getMovieCredits(id: Int) async throws -> MDBMovieCredits
}

class MovieRepository: MovieRepositoryProtocol {
    private let restClient: any RestClientProtocol

    init(restClient: RestClientProtocol = RestClient()) {
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
}
