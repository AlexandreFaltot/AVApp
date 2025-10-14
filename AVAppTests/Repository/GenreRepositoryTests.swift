//
//  GenreRepositoryTests.swift
//  AVApp
//
//  Created by Alexandre Faltot on 15/10/2025.
//

import Testing
@testable import AVApp

// MARK: - MovieRepository Tests
@MainActor
struct GenreRepositoryTests {
    // MARK: - Get Genres Tests
    @Test("getGenres should return genre response on success")
    func getPopularMoviesShouldReturnMoviesResponseOnSuccess() async throws {
        // Given
        let mockResponse = MDBGenreResponse.mock
        let mockRestClient = RestClientMock(mockResponse: mockResponse)
        let sut = GenreRepository(restClient: mockRestClient)

        // When
        let result = try await sut.getGenres()

        // Then
        #expect(result.genres.count == 10)
        #expect(mockRestClient.requestCallCount == 1)
    }

    @Test("getGenres should throw error on failure")
    func getPopularMoviesShouldCallRestClientWithCorrectPage() async throws {
        // Given
        let mockRestClient = RestClientMock(shouldThrowError: true)
        let sut = GenreRepository(restClient: mockRestClient)

        // When/Then
        await #expect(throws: Error.self) {
            try await sut.getGenres()
        }
    }
}

// MARK: - Mock Data Helpers
fileprivate extension Array where Element == MDBGenre {
    static var mockTenGenre: [MDBGenre] = (0..<10).map { MDBGenre(id: $0, name: "Genre \($0)") }
}

fileprivate extension MDBGenreResponse {
    static var mock = MDBGenreResponse(genres: .mockTenGenre)
}
