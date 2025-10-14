//
//  GetMovieDetailsUseCase.swift
//  AVApp
//
//  Created by Alexandre Faltot on 13/10/2025.
//

protocol GetMovieDetailsUseCaseProtocol: AsyncUseCaseProtocol where Parameters == GetMovieDetailsUseCaseParameters, Response == AVMovieDetails {}

struct GetMovieDetailsUseCaseParameters {
    let id: Int
}

class GetMovieDetailsUseCase: GetMovieDetailsUseCaseProtocol {
    private let movieRepository: any MovieRepositoryProtocol

    init(movieRepository: any MovieRepositoryProtocol = Module.shared.resolve()) {
        self.movieRepository = movieRepository
    }

    func execute(_ parameters: GetMovieDetailsUseCaseParameters) async throws -> AVMovieDetails {
        async let movieDetailsResult = try movieRepository.getMovieDetails(id: parameters.id)
        async let movieCreditsResult = try movieRepository.getMovieCredits(id: parameters.id)

        let (details, credits) = try await (movieDetailsResult, movieCreditsResult)
        return AVMovieDetails(mdbMovieDetails: details,
                              credits: credits)
    }
}

#if DEBUG
class GetMovieDetailsUseCaseErrorMock: GetMovieDetailsUseCaseProtocol {
    func execute(_ parameters: GetMovieDetailsUseCaseParameters) async throws -> AVMovieDetails { throw PreviewError.sample }
}
class GetMovieDetailsUseCaseMock: GetMovieDetailsUseCaseProtocol {
    func execute(_ parameters: GetMovieDetailsUseCaseParameters) async throws -> AVMovieDetails { .mock }
}
#endif
