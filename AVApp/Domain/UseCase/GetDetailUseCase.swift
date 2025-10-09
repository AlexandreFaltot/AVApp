//
//  GetListUseCase.swift
//  AVApp
//
//  Created by Alexandre Faltot on 09/10/2025.
//

protocol GetDetailUseCaseProtocol: AsyncUseCaseProtocol where Response == String, Parameters == String {}

class GetDetailUseCase: GetDetailUseCaseProtocol {
    private let repository: any ListRepositoryProtocol

    init(repository: ListRepositoryProtocol = ListRepository()) {
        self.repository = repository
    }

    func execute(_ parameters: String) async throws -> String {
        return try await repository.getList().messages.first ?? ""
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
