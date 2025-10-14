//
//  GetMovieDetailsUseCase.swift
//  AVApp
//
//  Created by Alexandre Faltot on 13/10/2025.
//

protocol SearchMoviesUseCaseProtocol: AsyncUseCaseProtocol where Parameters == SearchMoviesUseCaseParameters, Response == [AVMovie] {}

struct SearchMoviesUseCaseParameters {
    let query: String
}

class SearchMoviesUseCase: SearchMoviesUseCaseProtocol {
    private let movieRepository: any MovieRepositoryProtocol
    private let genreRepository: any GenreRepositoryProtocol

    init(movieRepository: any MovieRepositoryProtocol = Module.shared.resolve(),
         genreRepository: any GenreRepositoryProtocol = Module.shared.resolve()) {
        self.movieRepository = movieRepository
        self.genreRepository = genreRepository
    }

    func execute(_ parameters: SearchMoviesUseCaseParameters) async throws -> [AVMovie] {
        async let moviesRequest = movieRepository.searchMovies(query: parameters.query)
        async let genresRequest = genreRepository.getGenres()
        let (moviesResponse, genresResponse) = try await (moviesRequest, genresRequest)

        return moviesResponse.results.map { AVMovie(mdbMovie: $0, mdbGenres: genresResponse.genres) }
    }
}

#if DEBUG
class SearchMoviesUseCaseEmptyMock: SearchMoviesUseCaseProtocol {
    func execute(_ parameters: SearchMoviesUseCaseParameters) async throws -> [AVMovie] { [] }
}
class SearchMoviesUseCaseErrorMock: SearchMoviesUseCaseProtocol {
    func execute(_ parameters: SearchMoviesUseCaseParameters) async throws -> [AVMovie] { throw PreviewError.sample }
}
class SearchMoviesUseCaseMock: SearchMoviesUseCaseProtocol {
    func execute(_ parameters: SearchMoviesUseCaseParameters) async throws -> [AVMovie] { .mockTenMovies }
}
#endif
