//
//  DetailScreen.swift
//  AVApp
//
//  Created by Alexandre Faltot on 09/10/2025.
//

import SwiftUI

struct MovieDetailView<ViewModel: MovieDetailScreenViewModelProtocol>: View {
    @StateObject var viewModel: ViewModel

    var body: some View {
        AVAsyncView {
            try await viewModel.getMovieDetails()
        } content: { data in
            VStack {
                AVHeaderView(title: String(localized: .appTitle),
                         subtitle: data.title)
                ScrollView {
                    VStack(alignment: .leading, spacing: 0.0) {
                        AVMovieSnapshotView(movie: data)
                        if !data.synopsis.isEmpty {
                            AVSectionView(title: "Synopsis") {
                                Text(data.synopsis)
                                    .avStyle(.paragraph)
                            }
                        }
                        AVSectionView(title: String(localized: .headliners)) {
                            ScrollView(.horizontal) {
                                LazyHStack(spacing: 8.0) {
                                    ForEach(data.headliners, id: \.self) {
                                        AVHeadlinerSnapshotView(headliner: $0)
                                    }
                                }
                                .padding(.horizontal, 16.0)
                                .padding(.bottom, 8.0)
                            }
                            .scrollIndicators(.hidden)
                        }
                        .contentPadding(EdgeInsets())
                    }
                }
            }
            .background(.avPrimary)
        }
    }
}

#Preview("Error preview") {
    MovieDetailView(viewModel: MovieDetailScreenViewModel(movieId: 0, getMovieDetailsUseCase: GetMovieDetailsUseCaseErrorMock()))
}
#Preview("Movie preview") {
    MovieDetailView(viewModel: MovieDetailScreenViewModel(movieId: 0, getMovieDetailsUseCase: GetMovieDetailsUseCaseMock()))
}
    
