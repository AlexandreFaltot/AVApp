//
//  MovieSearchScreenView.swift
//  AVApp
//
//  Created by Alexandre Faltot on 14/10/2025.
//

import SwiftUI

struct MovieSearchScreenView: View {
    @State var qu: String = ""
    @StateObject var viewModel: MovieSearchScreenViewModel
    @FocusState private var textFieldIsFocused: Bool
    @Environment(\.dismiss) private var dismiss
    var onAskForMovieDetails: ((AVMovie) -> Void) = { _ in }

    var body: some View {
        VStack {
            AVHeaderView(title: String(localized: .appTitle)) {
                HStack(spacing: 8.0) {
                    Button {
                        dismiss()
                    } label: {
                        Image(.avBackButton)
                            .frame(width: 20, height: 28, alignment: .leading)
                    }
                    .padding(.vertical, 10.0)
                    .padding(.trailing, 8.0)

                    AVTextField(String(localized: .searchMovie),
                                text: $viewModel.query,
                                leadingIcon: .avSearch)
                    .focused($textFieldIsFocused)
                }
            }
            Rectangle()
                .frame(height: 1.0)
                .foregroundStyle(Color.avWhite)
                .padding(.horizontal, 16.0)
            ScrollView {
                AVAsyncView(state: viewModel.movies,
                            onRetry: {
                    Task {
                        await viewModel.searchMovies()
                    }
                }) { movies in
                    if movies.isEmpty {
                        Text(.noMovieResult)
                            .multilineTextAlignment(.center)
                            .avStyle(.paragraph)
                    } else {
                        LazyVStack(spacing: 16.0) {
                            ForEach(movies) { movie in
                                Button {
                                    onAskForMovieDetails(movie)
                                } label: {
                                    AVMovieSearchCell(movie: movie)
                                }

                            }
                        }
                        .padding(16.0)
                    }
                }
            }
        }
        .onLoad {
            textFieldIsFocused = true
            viewModel.initialize()
        }
        .background(Color.avPrimary)
    }
}

#if DEBUG
#Preview("Success preview") {
    PreviewContainer {
        MovieSearchScreenView(viewModel: MovieSearchScreenViewModel(searchMovieUseCase: SearchMoviesUseCaseMock()))
    }
}

#Preview("Error preview") {
    PreviewContainer {
        MovieSearchScreenView(viewModel: MovieSearchScreenViewModel(searchMovieUseCase: SearchMoviesUseCaseErrorMock()))
    }
}

#Preview("Empty list preview") {
    PreviewContainer {
        MovieSearchScreenView(viewModel: MovieSearchScreenViewModel(searchMovieUseCase: SearchMoviesUseCaseEmptyMock()))
    }
}
#endif
