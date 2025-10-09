//
//  DetailScreen.swift
//  AVApp
//
//  Created by Alexandre Faltot on 09/10/2025.
//

import SwiftUI

struct DetailScreenView: View {
    @Environment(\.getListUseCase) var getListUseCase: any GetListUseCaseProtocol

    var body: some View {
        AsyncView {
            try await getListUseCase.execute()
        } content: { data in
            Text(data.first ?? "No message")
        }
    }
}

#Preview("Error preview") {
    DetailScreenView()
        .withListUseCase(GetListUseCaseErrorMock())
}
#Preview("Empty list preview") {
    DetailScreenView()
        .withListUseCase(GetListUseCaseEmptyListMock())
}
#Preview("Normal list preview") {
    DetailScreenView()
        .withListUseCase(GetListUseCaseListMock())
}
