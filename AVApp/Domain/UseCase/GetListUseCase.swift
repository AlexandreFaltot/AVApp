//
//  GetListUseCase.swift
//  AVApp
//
//  Created by Alexandre Faltot on 09/10/2025.
//

protocol GetPopularMoviesUseCaseProtocol: AsyncUseCaseProtocol where Parameters == GetPopularMoviesParameters, Response == [AVMovie] {}

struct GetPopularMoviesParameters {
    var page: Int
}

class GetPopularMoviesUseCase: GetPopularMoviesUseCaseProtocol {
    private let movieRepository: any MovieRepositoryProtocol
    private let genreRepository: any GenreRepositoryProtocol

    init(movieRepository: any MovieRepositoryProtocol = MovieRepository(),
         genreRepository: any GenreRepositoryProtocol = GenreRepository()) {
        self.movieRepository = movieRepository
        self.genreRepository = genreRepository

    }

    func execute(_ parameters: GetPopularMoviesParameters) async throws -> [AVMovie] {
        async let moviesRequest = movieRepository.getPopularMovies(page: parameters.page)
        async let genresRequest = genreRepository.getGenres()
        let (moviesResponse, genresResponse) = try await (moviesRequest, genresRequest)

        return moviesResponse.results
            .map { AVMovie(mdbMovie: $0, mdbGenres: genresResponse.genres) }
    }
}

// MARK: - Mocks

#if DEBUG
class GetListUseCaseErrorMock: GetPopularMoviesUseCaseProtocol {
    func execute(_ parameters: GetPopularMoviesParameters) async throws -> [AVMovie] { throw PreviewError.sample }
}
class GetListUseCaseEmptyListMock: GetPopularMoviesUseCaseProtocol {
    func execute(_ parameters: GetPopularMoviesParameters) async throws -> [AVMovie] { [] }
}
class GetListUseCaseListMock: GetPopularMoviesUseCaseProtocol {
    func execute(_ parameters: GetPopularMoviesParameters) async throws -> [AVMovie] { .mockTenMovies }
}
#endif
