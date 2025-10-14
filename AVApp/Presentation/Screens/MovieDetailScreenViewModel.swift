//
//  MovieDetailScreenViewModel.swift
//  AVApp
//
//  Created by Alexandre Faltot on 09/10/2025.
//

import Combine

class MovieDetailScreenViewModel: ObservableObject {
    private let movieId: Int
    private let getMovieDetailsUseCase: any GetMovieDetailsUseCaseProtocol

    init(movieId: Int,
         getMovieDetailsUseCase: any GetMovieDetailsUseCaseProtocol = Module.shared.resolve(scope: \.instance)) {
        self.movieId = movieId
        self.getMovieDetailsUseCase = getMovieDetailsUseCase
    }
}

@MainActor
extension MovieDetailScreenViewModel {
    func getMovieDetails() async throws -> AVMovieDetails {
        try await getMovieDetailsUseCase.execute(.init(id: movieId))
    }
}
