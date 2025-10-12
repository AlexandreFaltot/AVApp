//
//  UseCase.swift
//  AVApp
//
//  Created by Alexandre Faltot on 09/10/2025.
//

struct VoidAsyncUseCase<Response> {
    private let _execute: () async throws -> Response

    init<UseCase: VoidAsyncUseCaseProtocol>(_ useCase: UseCase) where UseCase.Response == Response {
        self._execute = useCase.execute
    }

    func execute() async throws -> Response {
        try await _execute()
    }
}

struct AsyncUseCase<Parameters, Response> {
    private let _execute: (_ parameters: Parameters) async throws -> Response

    init<UseCase: AsyncUseCaseProtocol>(_ useCase: UseCase) where UseCase.Response == Response, UseCase.Parameters == Parameters {
        self._execute = useCase.execute
    }

    func execute(_ parameters: Parameters) async throws -> Response {
        try await _execute(parameters)
    }
}
