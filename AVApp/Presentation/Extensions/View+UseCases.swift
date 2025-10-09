//
//  View+UseCases.swift
//  AVApp
//
//  Created by Alexandre Faltot on 09/10/2025.
//

import SwiftUI

extension EnvironmentValues {
    @Entry var getDetailUseCase: any GetDetailUseCaseProtocol = GetDetailUseCase()
    @Entry var getListUseCase: any GetListUseCaseProtocol = GetListUseCase()
}

extension View {
    func withDetailUseCase(_ useCase: any GetDetailUseCaseProtocol) -> some View {
        environment(\.getDetailUseCase, useCase)
    }

    func withListUseCase(_ useCase: any GetListUseCaseProtocol) -> some View {
        environment(\.getListUseCase, useCase)
    }
}
