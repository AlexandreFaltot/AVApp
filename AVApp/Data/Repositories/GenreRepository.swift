//
//  GenreRepositoryProtocol.swift
//  AVApp
//
//  Created by Alexandre Faltot on 09/10/2025.
//

import Combine
import Foundation

protocol GenreRepositoryProtocol {
    ///
    /// Gets the genres from the Movie API
    ///
    /// - Returns: The API response
    ///
    func getGenres() async throws -> MDBGenreResponse
}

class GenreRepository: GenreRepositoryProtocol {
    private let restClient: RestClientProtocol

    init(restClient: RestClientProtocol = Module.shared.resolve()) {
        self.restClient = restClient
    }

    func getGenres() async throws -> MDBGenreResponse {
        return try await restClient.request(operation: MovieApiOperations.getGenres)
    }
}
