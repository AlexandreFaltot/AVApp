//
//  GenreRepositoryProtocol.swift
//  AVApp
//
//  Created by Alexandre Faltot on 09/10/2025.
//

import Combine
import Foundation

protocol GenreRepositoryProtocol {
    func getGenres() async throws -> MDBGenreResponse
}

class GenreRepository: GenreRepositoryProtocol {
    private let restClient: RestClientProtocol

    init(restClient: RestClientProtocol = RestClient.shared) {
        self.restClient = restClient
    }

    func getGenres() async throws -> MDBGenreResponse {
        return try await restClient.request(operation: MovieApiOperations.getGenres)
    }
}
