//
//  MovieListViewModel.swift
//  AVApp
//
//  Created by Alexandre Faltot on 10/10/2025.
//


import UIKit
import Combine
import SwiftUI

@MainActor
protocol MovieListViewModelProtocol {
    var moviesPublisher: AnyPublisher<AsyncState<[AVMovie]>, Never> { get }
    var nbOfMovies: Int { get }
    var shouldShowRetry: Bool { get }
    var shouldShowMovies: Bool { get }
    var shouldShowLoading: Bool { get }
    func initialize()
    func refreshMovies()
    func getNextMovies()
    func askForMovieDetails(at index: Int)
    func movie(at index: Int) -> AVMovie?
}

@MainActor
class MovieListViewModel: MovieListViewModelProtocol {
    @Published private var moviesResult: AsyncState<[AVMovie]> = .idle
    private var currentPage = 1
    private var fetchedMovies: [AVMovie] {
        guard case let .success(movies) = moviesResult else {
            return []
        }
        return movies
    }

    var moviesPublisher: AnyPublisher<AsyncState<[AVMovie]>, Never> { $moviesResult.eraseToAnyPublisher() }
    @Published var isGettingMovies = false
    var onAskForMovieDetails: ((AVMovie) -> Void)?
    var nbOfMovies: Int {
        fetchedMovies.count
    }
    var shouldShowRetry: Bool {
        moviesResult.isFailure && fetchedMovies.isEmpty
    }
    var shouldShowMovies: Bool {
        moviesResult.isSuccess && !fetchedMovies.isEmpty
    }
    var shouldShowLoading: Bool {
        moviesResult.isIdle
    }
    let getPopularMoviesUseCase: any GetPopularMoviesUseCaseProtocol

    init(getPopularMoviesUseCase: any GetPopularMoviesUseCaseProtocol) {
        self.getPopularMoviesUseCase = getPopularMoviesUseCase
    }

    func initialize() {
        refreshMovies()
    }

    func askForMovieDetails(at index: Int) {
        guard let movie = fetchedMovies[safe: index] else {
            return
        }

        onAskForMovieDetails?(movie)
    }

    func refreshMovies() {
        self.currentPage = 1

        Task { @MainActor in
            do {
                let result = try await getPopularMoviesUseCase.execute(.init(page: currentPage))
                self.moviesResult = .success(result: result)
            } catch {
                self.moviesResult = .failure(error: error)
            }
        }
    }

    @MainActor
    func getNextMovies() {
        Task {
            do {
                let result = try await getPopularMoviesUseCase.execute(.init(page: currentPage + 1))
                self.currentPage += 1
                self.moviesResult = .success(result: (moviesResult.result ?? []) + result)
            } catch {
                self.moviesResult = .failure(error: error)
            }
        }
    }

    func movie(at index: Int) -> AVMovie? {
        guard case let .success(movies) = moviesResult else {
            return nil
        }
        
        return movies[safe: index]
    }
}

#if DEBUG
class MockMovieListViewModel: MovieListViewModelProtocol {
    @Published private var moviesResult: AsyncState<[AVMovie]> = .idle
    private var movies: [AVMovie] { moviesResult.result ?? [] }

    var moviesPublisher: AnyPublisher<AsyncState<[AVMovie]>, Never> { $moviesResult.eraseToAnyPublisher() }
    var nbOfMovies: Int { movies.count }
    var shouldShowRetry: Bool {
        moviesResult.isFailure && movies.isEmpty
    }
    var shouldShowMovies: Bool {
        moviesResult.isSuccess && !movies.isEmpty
    }
    var shouldShowLoading: Bool {
        moviesResult.isIdle
    }

    func initialize() {}
    func askForMovieDetails(at index: Int) { }
    func refreshMovies() {
        moviesResult = .success(result: .mockTenMovies)
    }
    func getNextMovies() {
        moviesResult = .success(result: movies + .mockTenMovies)
    }
    func movie(at index: Int) -> AVMovie? {
        movies[safe: index]
    }
}
#endif
