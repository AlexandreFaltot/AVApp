//
//  GetListUseCase.swift
//  AVApp
//
//  Created by Alexandre Faltot on 09/10/2025.
//

protocol GetDetailUseCaseProtocol: AsyncUseCaseProtocol where Response == String, Parameters == String {}

class GetDetailUseCase: GetDetailUseCaseProtocol {
    private let repository: any MovieRepositoryProtocol

    init(repository: MovieRepositoryProtocol = MovieRepository()) {
        self.repository = repository
    }

    func execute(_ parameters: String) async throws -> String {
        return try await repository.getPopularMovies(page: 1).results.first?.title ?? ""
    }
}

// MARK: - Mocks

#if DEBUG
class GetDetailUseCaseErrorMock: GetDetailUseCaseProtocol {
    func execute(_ parameters: String) async throws -> String { throw PreviewError.sample }
}
class GetDetailUseCaseEmptyDetailMock: GetDetailUseCaseProtocol {
    func execute(_ parameters: String) async throws -> String { "" }
}
class GetDetailUseCaseMock: GetDetailUseCaseProtocol {
    func execute(_ parameters: String) async throws -> String { "Hello" }
}
#endif
