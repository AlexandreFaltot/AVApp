//
//  ListRepository.swift
//  AVApp
//
//  Created by Alexandre Faltot on 09/10/2025.
//

protocol ListRepositoryProtocol {
    func getList() async throws -> MyApiResponse
}

class ListRepository: ListRepositoryProtocol {
    private let restClient: any RestClientProtocol

    init(restClient: RestClientProtocol = RestClient()) {
        self.restClient = restClient
    }

    func getList() async throws -> MyApiResponse {
        return try await restClient.request(operation: MyApiOperations.getOperation)
    }
}
