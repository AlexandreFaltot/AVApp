//
//  MovieDetailScreenViewModel.swift
//  AVApp
//
//  Created by Alexandre Faltot on 09/10/2025.
//

import Combine

class MovieDetailScreenViewModel: ObservableObject {
    // MARK: - Private properties
    private let movieId: Int
    private let getMovieDetailsUseCase: any GetMovieDetailsUseCaseProtocol

    // MARK: - Init

    init(movieId: Int,
         getMovieDetailsUseCase: any GetMovieDetailsUseCaseProtocol = Module.shared.resolve(scope: \.instance)) {
        self.movieId = movieId
        self.getMovieDetailsUseCase = getMovieDetailsUseCase
    }
}

@MainActor
extension MovieDetailScreenViewModel {

    // MARK: - Public methods

    ///
    /// Gets the details of the movie
    ///
    /// - Returns: A ``AVMovieDetails`` representing the movie
    ///
    func getMovieDetails() async throws -> AVMovieDetails {
        try await getMovieDetailsUseCase.execute(.init(id: movieId))
    }
}
