//
//  UseCase.swift
//  AVApp
//
//  Created by Alexandre Faltot on 09/10/2025.
//


protocol VoidAsyncUseCaseProtocol {
    associatedtype Response
    func execute() async throws -> Response
}

protocol AsyncUseCaseProtocol {
    associatedtype Parameters
    associatedtype Response
    func execute(_ parameters: Parameters) async throws -> Response
}
