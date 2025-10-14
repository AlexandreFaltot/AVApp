//
//  MovieListViewModelTests.swift
//  AVAppTests
//
//  Created by Alexandre Faltot on 09/10/2025.
//

import Testing
@testable import AVApp
import Foundation

@MainActor
struct MovieListViewModelTests {
    // MARK: - Initialize Tests
    @Test("MovieListViewModel should give right nbOfMovies after initialize success")
    func viewModelInitializeSuccess() async throws {
        // Given
        let sut = MovieListViewModel(getPopularMoviesUseCase: GetPopularMoviesUseCaseMock())

        // When
        await sut.initialize()

        // Then
        #expect(sut.nbOfMovies == 10)
    }

    @Test("MovieListViewModel should give right nbOfMovies after initialize fail")
    func viewModelInitializeFailure() async throws {
        // Given
        let sut = MovieListViewModel(getPopularMoviesUseCase: GetPopularMoviesUseCaseErrorMock())

        // When
        await sut.initialize()

        // Then
        #expect(sut.nbOfMovies == 0)
    }

    // MARK: - Computed Properties Tests
    @Test("shouldShowRetry should be true when failure and no movies")
    func shouldShowRetryWhenFailureAndEmpty() async throws {
        // Given
        let sut = MovieListViewModel(getPopularMoviesUseCase: GetPopularMoviesUseCaseErrorMock())

        // When
        await sut.initialize()

        // Then
        #expect(sut.shouldShowRetry == true)
    }

    @Test("shouldShowRetry should be false when success")
    func shouldShowRetryWhenSuccess() async throws {
        // Given
        let sut = MovieListViewModel(getPopularMoviesUseCase: GetPopularMoviesUseCaseMock())

        // When
        await sut.initialize()

        // Then
        #expect(sut.shouldShowRetry == false)
    }

    @Test("shouldShowMovies should be true when success with movies")
    func shouldShowMoviesWhenSuccess() async throws {
        // Given
        let sut = MovieListViewModel(getPopularMoviesUseCase: GetPopularMoviesUseCaseMock())

        // When
        await sut.initialize()

        // Then
        #expect(sut.shouldShowMovies == true)
    }

    @Test("shouldShowMovies should be false when failure")
    func shouldShowMoviesWhenFailure() async throws {
        // Given
        let sut = MovieListViewModel(getPopularMoviesUseCase: GetPopularMoviesUseCaseErrorMock())

        // When
        await sut.initialize()

        // Then
        #expect(sut.shouldShowMovies == false)
    }

    @Test("shouldShowLoading should be true initially")
    func shouldShowLoadingInitially() async throws {
        // Given
        let sut = MovieListViewModel(getPopularMoviesUseCase: GetPopularMoviesUseCaseMock())

        // When
        // Then
        #expect(sut.shouldShowLoading == true)
    }

    @Test("shouldShowLoading should be false after success")
    func shouldShowLoadingAfterSuccess() async throws {
        // Given
        let sut = MovieListViewModel(getPopularMoviesUseCase: GetPopularMoviesUseCaseMock())

        // When
        await sut.initialize()

        // Then
        #expect(sut.shouldShowLoading == false)
    }

    // MARK: - Get Next Movies Tests
    @Test("getNextMovies should append more movies")
    func getNextMoviesShouldAppend() async throws {
        // Given
        let sut = MovieListViewModel(getPopularMoviesUseCase: GetPopularMoviesUseCaseMock())
        await sut.initialize()
        let initialCount = sut.nbOfMovies

        // When
        await sut.getNextMovies()

        // Then
        #expect(sut.nbOfMovies == initialCount * 2)
    }

    @Test("getNextMovies should not append on failure")
    func getNextMoviesShouldNotAppend() async throws {
        // Given
        let sut = MovieListViewModel(getPopularMoviesUseCase: GetPopularMoviesUseCaseNextPageErrorMock())
        await sut.initialize()

        // When
        await sut.getNextMovies()

        // Then
        #expect(sut.nbOfMovies == 0)
        #expect(sut.shouldShowRetry)
    }

    // MARK: - Refresh Movies Tests
    @Test("refreshMovies should reset movies and fetch from page 1")
    func refreshMoviesShouldResetAndFetch() async throws {
        // Given
        let sut = MovieListViewModel(getPopularMoviesUseCase: GetPopularMoviesUseCaseMock())
        await sut.initialize()
        let initialCount = sut.nbOfMovies

        await sut.getNextMovies()

        // When
        await sut.refreshMovies()

        // Then
        #expect(sut.nbOfMovies == initialCount)
    }

    // MARK: - Movie At Index Tests
    @Test("movie(at:) should return correct movie for valid index")
    func movieAtValidIndex() async throws {
        // Given
        let sut = MovieListViewModel(getPopularMoviesUseCase: GetPopularMoviesUseCaseMock())
        await sut.initialize()

        // When
        let movie = sut.movie(at: 0)

        // Then
        #expect(movie != nil)
    }

    @Test("movie(at:) should return nil for invalid index")
    func movieAtInvalidIndex() async throws {
        // Given
        let sut = MovieListViewModel(getPopularMoviesUseCase: GetPopularMoviesUseCaseMock())
        await sut.initialize()

        // When
        let movie = sut.movie(at: 999)

        // Then
        #expect(movie == nil)
    }

    @Test("movie(at:) should return nil when in failure state")
    func movieAtIndexWhenFailure() async throws {
        // Given
        let sut = MovieListViewModel(getPopularMoviesUseCase: GetPopularMoviesUseCaseErrorMock())
        await sut.initialize()

        // When
        let movie = sut.movie(at: 0)

        // Then
        #expect(movie == nil)
    }

    // MARK: - Ask For Movie Details Tests
    @Test("askForMovieDetails should trigger callback for valid index")
    func askForMovieDetailsShouldTriggerCallback() async throws {
        // Given
        let sut = MovieListViewModel(getPopularMoviesUseCase: GetPopularMoviesUseCaseMock())
        await sut.initialize()
        var callbackTriggered = false
        var receivedMovie: AVMovie?
        sut.onAskForMovieDetails = { movie in
            callbackTriggered = true
            receivedMovie = movie
        }

        // When
        sut.askForMovieDetails(at: 0)

        // Then
        #expect(callbackTriggered == true)
        #expect(receivedMovie != nil)
    }

    @Test("askForMovieDetails should not trigger callback for invalid index")
    func askForMovieDetailsShouldNotTriggerForInvalidIndex() async throws {
        // Given
        let sut = MovieListViewModel(getPopularMoviesUseCase: GetPopularMoviesUseCaseMock())
        await sut.initialize()

        var callbackTriggered = false
        sut.onAskForMovieDetails = { _ in
            callbackTriggered = true
        }

        // When
        sut.askForMovieDetails(at: 999)

        // Then
        #expect(callbackTriggered == false)
    }

    // MARK: - Ask For Movie Search Tests
    @Test("askForMovieSearch should trigger nicely")
    func askForMovieSearchShouldTriggerNicely() async throws {
        // Given
        let sut = MovieListViewModel(getPopularMoviesUseCase: GetPopularMoviesUseCaseMock())
        await sut.initialize()

        var callbackTriggered = false
        sut.onAskForMovieSearch = {
            callbackTriggered = true
        }

        // When
        sut.askForMovieSearch()

        // Then
        #expect(callbackTriggered == true)
    }
}

fileprivate class GetPopularMoviesUseCaseNextPageErrorMock: GetPopularMoviesUseCaseProtocol {
    func execute(_ parameters: GetPopularMoviesParameters) async throws -> Array<AVMovie> {
        switch parameters.page {
        case 1: return .mockTenMovies
        default: throw MockError.sample
        }
    }
}


