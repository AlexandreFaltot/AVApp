//
//  MovieDetailScreenViewModel.swift
//  AVApp
//
//  Created by Alexandre Faltot on 09/10/2025.
//

import Combine

class MovieDetailScreenViewModel: ObservableObject {
    let getListUseCase: any GetPopularMoviesUseCaseProtocol

    init(getListUseCase: any GetPopularMoviesUseCaseProtocol = GetPopularMoviesUseCase()) {
        self.getListUseCase = getListUseCase
    }

    func getMovieDetails() async throws -> AVMovie {
        let results = try await getListUseCase.execute(.init(page: 1))
        return results.first!
    }
}
