//
//  GetListUseCase.swift
//  AVApp
//
//  Created by Alexandre Faltot on 09/10/2025.
//

protocol GetListUseCaseProtocol: VoidAsyncUseCaseProtocol where Response == [String] {}

class GetListUseCase: GetListUseCaseProtocol {
    private let repository: any ListRepositoryProtocol

    init(repository: ListRepositoryProtocol = ListRepository()) {
        self.repository = repository
    }

    func execute() async throws -> [String] {
        let result = try await repository.getList()
        return result.messages
    }
}

// MARK: - Mocks

#if DEBUG
class GetListUseCaseErrorMock: GetListUseCaseProtocol {
    func execute() async throws -> [String] { throw PreviewError.sample }
}
class GetListUseCaseEmptyListMock: GetListUseCaseProtocol {
    func execute() async throws -> [String] { [] }
}
class GetListUseCaseListMock: GetListUseCaseProtocol {
    func execute() async throws -> [String] { ["One", "Two", "Three"] }
}
#endif
