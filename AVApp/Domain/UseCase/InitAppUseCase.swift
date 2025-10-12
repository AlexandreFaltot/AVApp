//
//  InitAppUseCase.swift
//  AVApp
//
//  Created by Alexandre Faltot on 09/10/2025.
//

protocol GetGenresUseCaseProtocol: VoidAsyncUseCaseProtocol where Response == [MDBGenre] {}

class GetGenresUseCase: GetGenresUseCaseProtocol {
    private let genreRepository: any GenreRepositoryProtocol

    init(genreRepository: any GenreRepositoryProtocol = GenreRepository()) {
        self.genreRepository = genreRepository
    }

    func execute() async throws -> [MDBGenre] {
        let response = try await genreRepository.getGenres()
        return response.genres
    }
}
