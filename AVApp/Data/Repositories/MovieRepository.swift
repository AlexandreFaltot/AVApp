//
//  ListRepository.swift
//  AVApp
//
//  Created by Alexandre Faltot on 09/10/2025.
//

protocol MovieRepositoryProtocol {
    func getPopularMovies(page: Int) async throws -> MDBMovieResponse
}

class MovieRepository: MovieRepositoryProtocol {
    private let restClient: any RestClientProtocol

    init(restClient: RestClientProtocol = RestClient()) {
        self.restClient = restClient
    }

    func getPopularMovies(page: Int) async throws -> MDBMovieResponse {
        return try await restClient.request(operation: MovieApiOperations.getPopularMovies(page: page))
    }

}
