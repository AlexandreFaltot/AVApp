//
//  MockDependencies.swift
//  AVApp
//
//  Created by Alexandre Faltot on 15/10/2025.
//

@testable import AVApp

extension Module {
    func registerMocks() {
        register((any GetPopularMoviesUseCaseProtocol).self, in: \.instance) { _ in GetPopularMoviesUseCaseMock() }
        register((any GetMovieDetailsUseCaseProtocol).self, in: \.instance) { _ in GetMovieDetailsUseCaseMock() }
        register((any SearchMoviesUseCaseProtocol).self, in: \.instance) { _ in SearchMoviesUseCaseMock() }
    }
}
