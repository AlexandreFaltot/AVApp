//
//  DetailScreen.swift
//  AVApp
//
//  Created by Alexandre Faltot on 09/10/2025.
//

import SwiftUI

struct MovieDetailScreen: View {
    // MARK: - Environment
    @StateObject var viewModel: MovieDetailScreenViewModel

    init(viewModel: MovieDetailScreenViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        AVAsyncView {
            try await viewModel.getMovieDetails()
        } content: { data in
            Text(data.title)
        }
    }
}
#Preview("Error preview") {
    MovieDetailScreen(viewModel: MovieDetailScreenViewModel(getListUseCase: GetListUseCaseErrorMock()))
}
#Preview("Empty list preview") {
    MovieDetailScreen(viewModel: MovieDetailScreenViewModel(getListUseCase: GetListUseCaseEmptyListMock()))
}
#Preview("Normal list preview") {
    MovieDetailScreen(viewModel: MovieDetailScreenViewModel(getListUseCase: GetListUseCaseErrorMock()))
}
