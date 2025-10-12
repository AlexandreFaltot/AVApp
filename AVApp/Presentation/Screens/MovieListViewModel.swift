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
    @Published private var moviesResult: AsyncState<[AVMovie]> = .idle
    private var currentPage = 1

    var onAskForMovieDetails: ((AVMovie) -> Void)?
    var fetchedMovies: [AVMovie] {
        guard case let .success(movies) = moviesResult else {
            return []
        }
        return movies
    }

    var moviesPublisher: AnyPublisher<AsyncState<[AVMovie]>, Never> { $moviesResult.eraseToAnyPublisher() }

    let getPopularMoviesUseCase: any GetPopularMoviesUseCaseProtocol

    init(getPopularMoviesUseCase: any GetPopularMoviesUseCaseProtocol) {
        self.getPopularMoviesUseCase = getPopularMoviesUseCase
    }

    func initialize() {
        Task {
            do {
                let result = try await getPopularMoviesUseCase.execute(.init(page: currentPage))
                self.moviesResult = .success(result: result)
            } catch {
                self.moviesResult = .failure(error: error)
            }
        }
    }

    func askForMovieDetails(at index: Int) {
        guard let movie = fetchedMovies[safe: index] else {
            return
        }

        onAskForMovieDetails?(movie)
    }

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
