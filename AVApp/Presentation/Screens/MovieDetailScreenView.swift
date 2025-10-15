//
//  DetailScreen.swift
//  AVApp
//
//  Created by Alexandre Faltot on 09/10/2025.
//

import SwiftUI

struct MovieDetailScreenView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel: MovieDetailScreenViewModel

    var body: some View {
        AVAsyncView {
            try await viewModel.getMovieDetails()
        } content: { data in
            VStack {
                AVHeaderView(title: String(localized: .appTitle)) {
                    Text(data.title)
                        .avStyle(.header2)
                }
                .frame(maxWidth: .infinity)
                .overlay(alignment: .topLeading) {
                    AVBackButton()
                        .padding(12.0)
                        .offset(y: 10.0)
                }
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
                    .padding(.bottom, 16.0)
                }
            }
            .background(.avPrimary)
        }
    }
}


#if DEBUG
#Preview("Movie preview") {
    PreviewContainer {
        MovieDetailScreenView(viewModel: MovieDetailScreenViewModel(movieId: 0, getMovieDetailsUseCase: GetMovieDetailsUseCaseMock()))
    }
}

#Preview("Error preview") {
    PreviewContainer {
        MovieDetailScreenView(viewModel: MovieDetailScreenViewModel(movieId: 0, getMovieDetailsUseCase: GetMovieDetailsUseCaseErrorMock()))
    }
}
#endif
