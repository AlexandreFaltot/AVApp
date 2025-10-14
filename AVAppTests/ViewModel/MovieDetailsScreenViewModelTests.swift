//
//  MovieDetailsScreenViewModelTests.swift
//  AVAppTests
//
//  Created by Alexandre Faltot on 09/10/2025.
//

import Testing
@testable import AVApp
import Foundation
import Testing

@MainActor
struct MovieDetailScreenViewModelTests {
    // MARK: - Initialize Tests
    @Test("MovieDetailScreenViewModel should initialize with correct movieId")
    func viewModelInitializeWithMovieId() async throws {
        // Given
        let movieId = 123

        // When
        let sut = MovieDetailScreenViewModel(
            movieId: movieId,
            getMovieDetailsUseCase: GetMovieDetailsUseCaseMock()
        )

        // Then
        let details = try await sut.getMovieDetails()
        #expect(details.id == movieId)
    }

    // MARK: - Get Movie Details Tests
    @Test("getMovieDetails should return movie details on success")
    func getMovieDetailsShouldReturnDetailsOnSuccess() async throws {
        // Given
        let movieId = 550
        let sut = MovieDetailScreenViewModel(
            movieId: movieId,
            getMovieDetailsUseCase: GetMovieDetailsUseCaseMock()
        )

        // When
        let details = try await sut.getMovieDetails()

        // Then
        #expect(details.id == movieId)
        #expect(details.title == "Movie \(movieId)")
    }

    @Test("getMovieDetails should throw error on failure")
    func getMovieDetailsShouldThrowErrorOnFailure() async throws {
        // Given
        let sut = MovieDetailScreenViewModel(
            movieId: 123,
            getMovieDetailsUseCase: GetMovieDetailsUseCaseErrorMock()
        )

        // When/Then
        await #expect(throws: Error.self) {
            try await sut.getMovieDetails()
        }
    }

    @Test("getMovieDetails should return correct details for different movie IDs")
    func getMovieDetailsShouldReturnCorrectDetailsForDifferentIds() async throws {
        // Given
        let firstMovieId = 100
        let secondMovieId = 200

        let firstSut = MovieDetailScreenViewModel(
            movieId: firstMovieId,
            getMovieDetailsUseCase: GetMovieDetailsUseCaseMock()
        )
        let secondSut = MovieDetailScreenViewModel(
            movieId: secondMovieId,
            getMovieDetailsUseCase: GetMovieDetailsUseCaseMock()
        )

        // When
        let firstDetails = try await firstSut.getMovieDetails()
        let secondDetails = try await secondSut.getMovieDetails()

        // Then
        #expect(firstDetails.id == firstMovieId)
        #expect(secondDetails.id == secondMovieId)
        #expect(firstDetails.id != secondDetails.id)
        #expect(firstDetails.title != secondDetails.title)
    }

    @Test("getMovieDetails should call use case with correct movie ID")
    func getMovieDetailsShouldCallUseCaseWithCorrectId() async throws {
        // Given
        let movieId = 999
        let mockUseCase = GetMovieDetailsUseCaseTrackingMock()
        let sut = MovieDetailScreenViewModel(
            movieId: movieId,
            getMovieDetailsUseCase: mockUseCase
        )

        // When
        _ = try await sut.getMovieDetails()

        // Then
        #expect(mockUseCase.lastCalledWithId == movieId)
        #expect(mockUseCase.callCount == 1)
    }

    @Test("getMovieDetails should be callable multiple times")
    func getMovieDetailsShouldBeCallableMultipleTimes() async throws {
        // Given
        let movieId = 456
        let mockUseCase = GetMovieDetailsUseCaseTrackingMock()
        let sut = MovieDetailScreenViewModel(
            movieId: movieId,
            getMovieDetailsUseCase: mockUseCase
        )

        // When
        _ = try await sut.getMovieDetails()
        _ = try await sut.getMovieDetails()
        _ = try await sut.getMovieDetails()

        // Then
        #expect(mockUseCase.callCount == 3)
    }

    @Test("getMovieDetails should handle special movie IDs")
    func getMovieDetailsShouldHandleSpecialIds() async throws {
        // Given - Test with edge case IDs
        let zeroIdSut = MovieDetailScreenViewModel(
            movieId: 0,
            getMovieDetailsUseCase: GetMovieDetailsUseCaseMock()
        )
        let negativeIdSut = MovieDetailScreenViewModel(
            movieId: -1,
            getMovieDetailsUseCase: GetMovieDetailsUseCaseMock()
        )

        // When
        let zeroDetails = try await zeroIdSut.getMovieDetails()
        let negativeDetails = try await negativeIdSut.getMovieDetails()

        // Then
        #expect(zeroDetails.id == 0)
        #expect(negativeDetails.id == -1)
    }

    @Test("getMovieDetails should propagate specific error types")
    func getMovieDetailsShouldPropagateSpecificErrors() async throws {
        // Given
        let sut = MovieDetailScreenViewModel(
            movieId: 123,
            getMovieDetailsUseCase: GetMovieDetailsUseCaseCustomErrorMock()
        )

        // When/Then
        do {
            _ = try await sut.getMovieDetails()
            #expect(Bool(false), "Should have thrown an error")
        } catch let error as MovieDetailError {
            #expect(error == .notFound)
        } catch {
            #expect(Bool(false), "Should throw MovieDetailError")
        }
    }
}

// MARK: - Mock Use Cases
fileprivate class GetMovieDetailsUseCaseMock: GetMovieDetailsUseCaseProtocol {
    func execute(_ parameters: GetMovieDetailsUseCaseParameters) async throws -> AVMovieDetails {
        return AVMovieDetails.init(id: parameters.id,
                                   title: "Movie \(parameters.id)",
                                   posterFilePath: "",
                                   backdropFilePath: "",
                                   runtime: 100,
                                   releaseDate: nil,
                                   genres: [],
                                   rating: 1.0,
                                   numberOfRatings: 0,
                                   synopsis: "",
                                   headliners: [],
                                   directors: [])
    }
}

fileprivate class GetMovieDetailsUseCaseErrorMock: GetMovieDetailsUseCaseProtocol {
    func execute(_ parameters: GetMovieDetailsUseCaseParameters) async throws -> AVMovieDetails {
        throw NSError(domain: "MovieDetailError", code: -1, userInfo: nil)
    }
}

fileprivate class GetMovieDetailsUseCaseTrackingMock: GetMovieDetailsUseCaseProtocol {
    private(set) var callCount = 0
    private(set) var lastCalledWithId: Int?

    func execute(_ parameters: GetMovieDetailsUseCaseParameters) async throws -> AVMovieDetails {
        callCount += 1
        lastCalledWithId = parameters.id

        return AVMovieDetails.init(id: parameters.id,
                                   title: "Movie \(parameters.id)",
                                   posterFilePath: "",
                                   backdropFilePath: "",
                                   runtime: 100,
                                   releaseDate: nil,
                                   genres: [],
                                   rating: 1.0,
                                   numberOfRatings: 0,
                                   synopsis: "",
                                   headliners: [],
                                   directors: [])
    }
}

enum MovieDetailError: Error, Equatable {
    case notFound
    case networkError
}

fileprivate class GetMovieDetailsUseCaseCustomErrorMock: GetMovieDetailsUseCaseProtocol {
    func execute(_ parameters: GetMovieDetailsUseCaseParameters) async throws -> AVMovieDetails {
        throw MovieDetailError.notFound
    }
}
