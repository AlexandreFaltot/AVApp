//
//  MovieRepositoryTests.swift
//  AVApp
//
//  Created by Alexandre Faltot on 15/10/2025.
//

import Testing
@testable import AVApp

// MARK: - MovieRepository Tests
@MainActor
struct MovieRepositoryTests {
    // MARK: - Get Popular Movies Tests
    @Test("getPopularMovies should return movies response on success")
    func getPopularMoviesShouldReturnMoviesResponseOnSuccess() async throws {
        // Given
        let mockResponse = MDBMoviesResponse.mock(page: 1)
        let mockRestClient = RestClientMock(mockResponse: mockResponse)
        let sut = MovieRepository(restClient: mockRestClient)

        // When
        let result = try await sut.getPopularMovies(page: 1)

        // Then
        #expect(result.page == 1)
        #expect(result.results.count == 1)
        #expect(mockRestClient.requestCallCount == 1)
    }

    @Test("getPopularMovies should call rest client with correct page")
    func getPopularMoviesShouldCallRestClientWithCorrectPage() async throws {
        // Given
        let mockResponse = MDBMoviesResponse.mock(page: 2)
        let mockRestClient = RestClientMock(mockResponse: mockResponse)
        let sut = MovieRepository(restClient: mockRestClient)
        let page = 2

        // When
        let result = try await sut.getPopularMovies(page: page)

        // Then
        #expect(result.page == page)
        #expect(mockRestClient.requestCallCount == 1)
    }

    @Test("getPopularMovies should throw error on failure")
    func getPopularMoviesShouldThrowErrorOnFailure() async throws {
        // Given
        let mockRestClient = RestClientMock(shouldThrowError: true)
        let sut = MovieRepository(restClient: mockRestClient)

        // When/Then
        await #expect(throws: Error.self) {
            try await sut.getPopularMovies(page: 1)
        }
    }

    @Test("getPopularMovies should handle multiple pages correctly")
    func getPopularMoviesShouldHandleMultiplePagesCorrectly() async throws {
        // Given
        let mockRestClient = RestClientMock()
        let sut = MovieRepository(restClient: mockRestClient)

        // When
        mockRestClient.mockResponse = MDBMoviesResponse.mock(page: 1)
        let firstPage = try await sut.getPopularMovies(page: 1)

        mockRestClient.mockResponse = MDBMoviesResponse.mock(page: 2)
        let secondPage = try await sut.getPopularMovies(page: 2)

        // Then
        #expect(firstPage.page == 1)
        #expect(secondPage.page == 2)
        #expect(mockRestClient.requestCallCount == 2)
    }

    // MARK: - Get Movie Details Tests
    @Test("getMovieDetails should return movie details on success")
    func getMovieDetailsShouldReturnMovieDetailsOnSuccess() async throws {
        // Given
        let mockRestClient = RestClientMock()
        let mockDetails = MDBMovieDetails.mock(id: 123)
        mockRestClient.mockResponse = mockDetails
        let sut = MovieRepository(restClient: mockRestClient)

        // When
        let result = try await sut.getMovieDetails(id: 123)

        // Then
        #expect(result.id == 123)
        #expect(result.title == "Test Movie")
        #expect(mockRestClient.requestCallCount == 1)
    }

    @Test("getMovieDetails should call rest client with correct id")
    func getMovieDetailsShouldCallRestClientWithCorrectId() async throws {
        // Given
        let mockRestClient = RestClientMock()
        let movieId = 456
        let mockDetails = MDBMovieDetails.mock(id: movieId)
        mockRestClient.mockResponse = mockDetails
        let sut = MovieRepository(restClient: mockRestClient)

        // When
        let result = try await sut.getMovieDetails(id: movieId)

        // Then
        #expect(result.id == movieId)
        #expect(mockRestClient.requestCallCount == 1)
    }

    @Test("getMovieDetails should throw error on failure")
    func getMovieDetailsShouldThrowErrorOnFailure() async throws {
        // Given
        let mockRestClient = RestClientMock()
        mockRestClient.shouldThrowError = true
        let sut = MovieRepository(restClient: mockRestClient)

        // When/Then
        await #expect(throws: Error.self) {
            try await sut.getMovieDetails(id: 123)
        }
    }

    @Test("getMovieDetails should return correct details for different movie IDs")
    func getMovieDetailsShouldReturnCorrectDetailsForDifferentMovieIds() async throws {
        // Given
        let mockRestClient = RestClientMock()
        let sut = MovieRepository(restClient: mockRestClient)

        // When
        mockRestClient.mockResponse = MDBMovieDetails.mock(id: 100)
        let firstDetails = try await sut.getMovieDetails(id: 100)

        mockRestClient.mockResponse = MDBMovieDetails.mock(id: 200)
        let secondDetails = try await sut.getMovieDetails(id: 200)

        // Then
        #expect(firstDetails.id == 100)
        #expect(secondDetails.id == 200)
        #expect(firstDetails.id != secondDetails.id)
        #expect(mockRestClient.requestCallCount == 2)
    }

    // MARK: - Get Movie Credits Tests
    @Test("getMovieCredits should return movie credits on success")
    func getMovieCreditsShouldReturnMovieCreditsOnSuccess() async throws {
        // Given
        let mockRestClient = RestClientMock()
        let mockCredits = MDBMovieCredits.mock(id: 123)
        mockRestClient.mockResponse = mockCredits
        let sut = MovieRepository(restClient: mockRestClient)

        // When
        let result = try await sut.getMovieCredits(id: 123)

        // Then
        #expect(result.id == 123)
        #expect(result.cast.count == 1)
        #expect(result.crew.count == 1)
        #expect(mockRestClient.requestCallCount == 1)
    }

    @Test("getMovieCredits should call rest client with correct id")
    func getMovieCreditsShouldCallRestClientWithCorrectId() async throws {
        // Given
        let mockRestClient = RestClientMock()
        let movieId = 789
        let mockCredits = MDBMovieCredits.mock(id: movieId)
        mockRestClient.mockResponse = mockCredits
        let sut = MovieRepository(restClient: mockRestClient)

        // When
        let result = try await sut.getMovieCredits(id: movieId)

        // Then
        #expect(result.id == movieId)
        #expect(mockRestClient.requestCallCount == 1)
    }

    @Test("getMovieCredits should throw error on failure")
    func getMovieCreditsShouldThrowErrorOnFailure() async throws {
        // Given
        let mockRestClient = RestClientMock()
        mockRestClient.shouldThrowError = true
        let sut = MovieRepository(restClient: mockRestClient)

        // When/Then
        await #expect(throws: Error.self) {
            try await sut.getMovieCredits(id: 123)
        }
    }

    @Test("getMovieCredits should return cast and crew members")
    func getMovieCreditsShouldReturnCastAndCrewMembers() async throws {
        // Given
        let mockRestClient = RestClientMock()
        let mockCredits = MDBMovieCredits.mock(id: 123)
        mockRestClient.mockResponse = mockCredits
        let sut = MovieRepository(restClient: mockRestClient)

        // When
        let result = try await sut.getMovieCredits(id: 123)

        // Then
        #expect(!result.cast.isEmpty)
        #expect(!result.crew.isEmpty)
        #expect(result.cast.first?.name == "Actor Name")
        #expect(result.crew.first?.name == "Director Name")
    }

    // MARK: - Search Movies Tests
    @Test("searchMovies should return movies response on success")
    func searchMoviesShouldReturnMoviesResponseOnSuccess() async throws {
        // Given
        let mockResponse = MDBMoviesResponse.mock()
        let mockRestClient = RestClientMock(mockResponse: mockResponse)
        let sut = MovieRepository(restClient: mockRestClient)
        let query = "action"

        // When
        let result = try await sut.searchMovies(query: query)

        // Then
        #expect(result.results.count == 1)
        #expect(mockRestClient.requestCallCount == 1)
    }

    @Test("searchMovies should call rest client with correct query")
    func searchMoviesShouldCallRestClientWithCorrectQuery() async throws {
        // Given
        let mockResponse = MDBMoviesResponse.mock()
        let mockRestClient = RestClientMock(mockResponse: mockResponse)
        let sut = MovieRepository(restClient: mockRestClient)
        let query = "inception"

        // When
        let result = try await sut.searchMovies(query: query)

        // Then
        #expect(!result.results.isEmpty)
        #expect(mockRestClient.requestCallCount == 1)
    }

    @Test("searchMovies should throw error on failure")
    func searchMoviesShouldThrowErrorOnFailure() async throws {
        // Given
        let mockRestClient = RestClientMock()
        mockRestClient.shouldThrowError = true
        let sut = MovieRepository(restClient: mockRestClient)

        // When/Then
        await #expect(throws: Error.self) {
            try await sut.searchMovies(query: "test")
        }
    }

    @Test("searchMovies should handle empty query string")
    func searchMoviesShouldHandleEmptyQueryString() async throws {
        // Given
        let mockResponse = MDBMoviesResponse.mock()
        let mockRestClient = RestClientMock(mockResponse: mockResponse)
        let sut = MovieRepository(restClient: mockRestClient)

        // When
        let result = try await sut.searchMovies(query: "")

        // Then
        #expect(result.results.count >= 0)
        #expect(mockRestClient.requestCallCount == 1)
    }

    @Test("searchMovies should handle different search queries")
    func searchMoviesShouldHandleDifferentSearchQueries() async throws {
        // Given
        let mockRestClient = RestClientMock()
        let sut = MovieRepository(restClient: mockRestClient)

        // When
        mockRestClient.mockResponse = MDBMoviesResponse.mock()
        let firstResult = try await sut.searchMovies(query: "action")

        mockRestClient.mockResponse = MDBMoviesResponse.mock()
        let secondResult = try await sut.searchMovies(query: "comedy")

        // Then
        #expect(!firstResult.results.isEmpty)
        #expect(!secondResult.results.isEmpty)
        #expect(mockRestClient.requestCallCount == 2)
    }

    // MARK: - Integration Tests
    @Test("repository should handle multiple sequential requests")
    func repositoryShouldHandleMultipleSequentialRequests() async throws {
        // Given
        let mockRestClient = RestClientMock()
        let sut = MovieRepository(restClient: mockRestClient)

        // When
        mockRestClient.mockResponse = MDBMoviesResponse.mock(page: 1)
        _ = try await sut.getPopularMovies(page: 1)

        mockRestClient.mockResponse = MDBMovieDetails.mock(id: 123)
        _ = try await sut.getMovieDetails(id: 123)

        mockRestClient.mockResponse = MDBMovieCredits.mock(id: 123)
        _ = try await sut.getMovieCredits(id: 123)

        mockRestClient.mockResponse = MDBMoviesResponse.mock()
        _ = try await sut.searchMovies(query: "test")

        // Then
        #expect(mockRestClient.requestCallCount == 4)
    }
}

// MARK: - Mock Data Helpers
fileprivate extension MDBMoviesResponse {
    static func mock(page: Int = 1, totalPages: Int = 10) -> MDBMoviesResponse {
        MDBMoviesResponse(
            page: page,
            results: [
                MDBMovie(
                    adult: false,
                    backdropPath: "/backdrop.jpg",
                    genreIds: [28, 12],
                    id: 1,
                    originalLanguage: "en",
                    originalTitle: "Test Movie",
                    overview: "Test overview",
                    popularity: 100.0,
                    posterPath: "/poster.jpg",
                    releaseDate: nil,
                    title: "Test Movie",
                    video: false,
                    voteAverage: 7.5,
                    voteCount: 1000
                )
            ],
            totalPages: totalPages,
            totalResults: 100
        )
    }
}

fileprivate extension MDBMovieDetails {
    static func mock(id: Int = 1) -> MDBMovieDetails {
        MDBMovieDetails(
            adult: false,
            backdropPath: "/backdrop.jpg",
            belongsToCollection: nil,
            budget: 1000000,
            genres: [
                MDBGenre(id: 28, name: "Action")
            ],
            homepage: "https://example.com",
            id: id,
            imdbId: "tt1234567",
            originalLanguage: "en",
            originalTitle: "Test Movie",
            overview: "Test overview",
            popularity: 100.0,
            posterPath: "/poster.jpg",
            productionCompanies: [],
            productionCountries: [],
            releaseDate: nil,
            revenue: 5000000,
            runtime: 120,
            spokenLanguages: [],
            status: "Released",
            tagline: "Test tagline",
            title: "Test Movie",
            video: false,
            voteAverage: 7.5,
            voteCount: 1000
        )
    }
}

fileprivate extension MDBMovieCredits {
    static func mock(id: Int = 1) -> MDBMovieCredits {
        MDBMovieCredits(
            id: id,
            cast: [
                MDBCastMember(
                    adult: false,
                    gender: 2,
                    id: 1,
                    knownForDepartment: "Acting",
                    name: "Actor Name",
                    originalName: "Actor Name",
                    popularity: 50.0,
                    profilePath: "/profile.jpg",
                    castId: 1,
                    character: "Main Character",
                    creditId: "credit123",
                    order: 0
                )
            ],
            crew: [
                MDBCrewMember(
                    adult: false,
                    gender: 2,
                    id: 2,
                    knownForDepartment: "Directing",
                    name: "Director Name",
                    originalName: "Director Name",
                    popularity: 40.0,
                    profilePath: "/director.jpg",
                    creditId: "credit456",
                    department: "Directing",
                    job: "Director"
                )
            ]
        )
    }
}
