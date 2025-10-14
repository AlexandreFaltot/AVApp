//
//  MovieListViewModel.swift
//  AVApp
//
//  Created by Alexandre Faltot on 10/10/2025.
//

import UIKit
import Combine
import SwiftUI

class MovieListViewModel {
    // MARK: - Private properties
    @Published private var moviesResult: AsyncState<[AVMovie]> = .loading
    private let getPopularMoviesUseCase: any GetPopularMoviesUseCaseProtocol
    private var currentPage = 1
    private var fetchedMovies: [AVMovie] {
        guard case let .success(movies) = moviesResult else {
            return []
        }
        return movies
    }

    // MARK: - Public properties
    @Published var isGettingMovies = false
    var moviesPublisher: AnyPublisher<AsyncState<[AVMovie]>, Never> { $moviesResult.eraseToAnyPublisher() }
    var onAskForMovieDetails: ((AVMovie) -> Void)?
    var onAskForMovieSearch: (() -> Void)?

    // MARK: - Computed properties
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
        moviesResult.isLoading
    }

    // MARK: - Init
    init(getPopularMoviesUseCase: any GetPopularMoviesUseCaseProtocol = Module.shared.resolve(scope: \.instance)) {
        self.getPopularMoviesUseCase = getPopularMoviesUseCase
    }
}

// MARK: - Public methods
@MainActor
extension MovieListViewModel {
    func initialize() async {
        await refreshMovies()
    }

    func refreshMovies() async {
        self.currentPage = 1

        do {
            let result = try await getPopularMoviesUseCase.execute(.init(page: currentPage))
            self.moviesResult = .success(result: result)
        } catch {
            self.moviesResult = .failure(error: error)
        }

    }

    func getNextMovies() async {
        do {
            let result = try await getPopularMoviesUseCase.execute(.init(page: currentPage + 1))
            self.currentPage += 1
            self.moviesResult = .success(result: (moviesResult.result ?? []) + result)
        } catch {
            self.moviesResult = .failure(error: error)
        }
    }

    func movie(at index: Int) -> AVMovie? {
        guard case let .success(movies) = moviesResult else {
            return nil
        }

        return movies[safe: index]
    }

    func askForMovieDetails(at index: Int) {
        guard let movie = fetchedMovies[safe: index] else {
            return
        }

        onAskForMovieDetails?(movie)
    }

    func askForMovieSearch() {
        onAskForMovieSearch?()
    }
}
