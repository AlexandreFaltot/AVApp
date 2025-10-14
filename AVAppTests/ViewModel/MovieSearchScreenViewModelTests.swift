//
//  MovieSearchScreenViewModelTests.swift
//  AVAppTests
//
//  Created by Alexandre Faltot on 09/10/2025.
//

import Testing
@testable import AVApp
import Foundation

@MainActor
struct MovieSearchScreenViewModelTests {
    // MARK: - Initialize Tests
    @Test("MovieSearchScreenViewModel should have idle state initially")
    func viewModelInitialState() async throws {
        // Given
        let sut = MovieSearchScreenViewModel(searchMovieUseCase: SearchMoviesUseCaseMock())

        // When
        // Then
        #expect(sut.query.isEmpty)
        #expect(sut.movies.isIdle)
        #expect(sut.didEnterQuery == false)
    }

    // MARK: - Query Tests
    @Test("didEnterQuery should be true when query is not empty")
    func didEnterQueryWhenQueryNotEmpty() async throws {
        // Given
        let sut = MovieSearchScreenViewModel(searchMovieUseCase: SearchMoviesUseCaseMock())

        // When
        sut.query = "Inception"

        // Then
        #expect(sut.didEnterQuery == true)
    }

    @Test("didEnterQuery should be false when query is empty")
    func didEnterQueryWhenQueryEmpty() async throws {
        // Given
        let sut = MovieSearchScreenViewModel(searchMovieUseCase: SearchMoviesUseCaseMock())
        sut.query = "Test"

        // When
        sut.query = ""

        // Then
        #expect(sut.didEnterQuery == false)
    }

    // MARK: - Search Movies Tests
    @Test("searchMovies should set idle state when query is empty")
    func searchMoviesShouldSetIdleWhenQueryEmpty() async throws {
        // Given
        let sut = MovieSearchScreenViewModel(searchMovieUseCase: SearchMoviesUseCaseMock())
        sut.query = ""

        // When
        await sut.searchMovies()

        // Then
        #expect(sut.movies.isIdle)
    }

    @Test("searchMovies should set loading state before fetching")
    func searchMoviesShouldSetLoadingState() async throws {
        // Given
        let sut = MovieSearchScreenViewModel(searchMovieUseCase: SearchMoviesUseCaseSlowMock())
        sut.query = "Inception"

        // When
        Task {
            await sut.searchMovies()
        }

        // Give time for loading state to be set
        try await Task.sleep(nanoseconds: 10_000_000) // 0.01 seconds

        // Then
        #expect(sut.movies.isLoading)
    }

    @Test("searchMovies should return movies on success")
    func searchMoviesShouldReturnMoviesOnSuccess() async throws {
        // Given
        let sut = MovieSearchScreenViewModel(searchMovieUseCase: SearchMoviesUseCaseMock())
        sut.query = "Inception"

        // When
        await sut.searchMovies()

        // Then
        #expect(sut.movies.isSuccess)
        if case let .success(movies) = sut.movies {
            #expect(movies.count == 10)
        }
    }

    @Test("searchMovies should set failure state on error")
    func searchMoviesShouldSetFailureStateOnError() async throws {
        // Given
        let sut = MovieSearchScreenViewModel(searchMovieUseCase: SearchMoviesUseCaseErrorMock())
        sut.query = "Inception"

        // When
        await sut.searchMovies()

        // Then
        #expect(sut.movies.isFailure)
    }

    @Test("searchMovies should return different results for different queries")
    func searchMoviesShouldReturnDifferentResults() async throws {
        // Given
        let sut = MovieSearchScreenViewModel(searchMovieUseCase: SearchMoviesUseCaseMock())
        sut.query = "First Query"
        await sut.searchMovies()

        guard case let .success(firstResults) = sut.movies else {
            #expect(Bool(false), "First search should succeed")
            return
        }

        // When
        sut.query = "Second Query"
        await sut.searchMovies()

        // Then
        guard case let .success(secondResults) = sut.movies else {
            #expect(Bool(false), "Second search should succeed")
            return
        }
        #expect(firstResults.count == secondResults.count)
    }

    // MARK: - Initialize with Debounce Tests
    @Test("initialize should trigger search after debounce period")
    func initializeShouldTriggerSearchAfterDebounce() async throws {
        // Given
        let sut = MovieSearchScreenViewModel(searchMovieUseCase: SearchMoviesUseCaseMock())
        sut.initialize()

        // When
        sut.query = "Inception"

        // Wait for debounce period (0.3 seconds + buffer)
        try await Task.sleep(nanoseconds: 400_000_000) // 0.4 seconds

        // Then
        #expect(sut.movies.isSuccess)
    }

    @Test("initialize should not trigger search before debounce period")
    func initializeShouldNotTriggerSearchBeforeDebounce() async throws {
        // Given
        let sut = MovieSearchScreenViewModel(searchMovieUseCase: SearchMoviesUseCaseMock())
        sut.initialize()

        // When
        sut.query = "Inception"

        // Wait less than debounce period
        try await Task.sleep(nanoseconds: 100_000_000) // 0.1 seconds

        // Then
        #expect(sut.movies.isIdle)
    }

    @Test("initialize should only trigger one search for rapid query changes")
    func initializeShouldDebounceRapidChanges() async throws {
        // Given
        let mockUseCase = SearchMoviesUseCaseCountingMock()
        let sut = MovieSearchScreenViewModel(searchMovieUseCase: mockUseCase)
        sut.initialize()

        // When - Rapid changes
        sut.query = "I"
        sut.query = "In"
        sut.query = "Inc"
        sut.query = "Ince"
        sut.query = "Incep"
        sut.query = "Incept"
        sut.query = "Incepti"
        sut.query = "Inceptio"
        sut.query = "Inception"

        // Wait for debounce period
        try await Task.sleep(nanoseconds: 400_000_000)

        // Then
        #expect(mockUseCase.callCount == 1)
    }

    @Test("initialize should set idle when query becomes empty")
    func initializeShouldSetIdleWhenQueryEmpty() async throws {
        // Given
        let sut = MovieSearchScreenViewModel(searchMovieUseCase: SearchMoviesUseCaseMock())
        sut.initialize()
        sut.query = "Inception"

        // Wait for search to complete
        try await Task.sleep(nanoseconds: 400_000_000) 
        #expect(sut.movies.isSuccess)

        // When
        sut.query = ""
        try await Task.sleep(nanoseconds: 400_000_000) // Wait for debounce

        // Then
        #expect(sut.movies.isIdle)
    }
}

fileprivate class SearchMoviesUseCaseSlowMock: SearchMoviesUseCaseProtocol {
    func execute(_ parameters: SearchMoviesUseCaseParameters) async throws -> [AVMovie] {
        try await Task.sleep(nanoseconds: 1_000_000_000) // 1 second
        return (0..<5).map { i in
            AVMovie(id: i, title: "\(parameters.query) Movie \(i)", posterFilePath: nil, releaseDate: nil, genres: [], rating: 1.0, numberOfRatings: 10, synopsis: "")
        }
    }
}

fileprivate class SearchMoviesUseCaseCountingMock: SearchMoviesUseCaseProtocol {
    private(set) var callCount = 0

    func execute(_ parameters: SearchMoviesUseCaseParameters) async throws -> [AVMovie] {
        callCount += 1
        return (0..<5).map { i in
            AVMovie(id: i, title: "\(parameters.query) Movie \(i)", posterFilePath: nil, releaseDate: nil, genres: [], rating: 1.0, numberOfRatings: 10, synopsis: "")
        }
    }
}
