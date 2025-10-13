//
//  MovieDetailScreenViewModel.swift
//  AVApp
//
//  Created by Alexandre Faltot on 09/10/2025.
//

import Combine

protocol MovieDetailScreenViewModelProtocol: ObservableObject {
    func getMovieDetails() async throws -> AVMovieDetails
}

class MovieDetailScreenViewModel: MovieDetailScreenViewModelProtocol {
    private let movieId: Int
    private let getMovieDetailsUseCase: any GetMovieDetailsUseCaseProtocol

    init(movieId: Int,
         getMovieDetailsUseCase: any GetMovieDetailsUseCaseProtocol = GetMovieDetailsUseCase()) {
        self.movieId = movieId
        self.getMovieDetailsUseCase = getMovieDetailsUseCase
    }

    func getMovieDetails() async throws -> AVMovieDetails {
        try await getMovieDetailsUseCase.execute(.init(id: movieId))
    }
}
