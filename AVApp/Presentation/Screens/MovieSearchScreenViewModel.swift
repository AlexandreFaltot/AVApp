//
//  MovieSearchScreenViewModel.swift
//  AVApp
//
//  Created by Alexandre Faltot on 15/10/2025.
//


import Combine
import Foundation

class MovieSearchScreenViewModel: ObservableObject {
    // MARK: - Public properties
    @Published var query: String = ""
    @Published var movies: AsyncState<[AVMovie]> = .idle
    var didEnterQuery: Bool { !query.isEmpty }

    // MARK: - Private properties
    private var cancellables: Set<AnyCancellable> = []
    private var searchMovieUseCase: any SearchMoviesUseCaseProtocol

    // MARK: - Init
    init(searchMovieUseCase: any SearchMoviesUseCaseProtocol = Module.shared.resolve(scope: \.instance)) {
        self.searchMovieUseCase = searchMovieUseCase
    }
}

@MainActor
extension MovieSearchScreenViewModel {

    // MARK: - Public methods

    ///
    /// Sets up the object so it listen to the query changes to fetch movies
    ///
    func initialize() {
        $query
            .debounce(for: .seconds(0.3), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] _ in
                Task {
                    await self?.searchMovies()
                }
            }
            .store(in: &cancellables)
    }
    
    ///
    /// Fetches movies from the API based on the query string
    ///
    func searchMovies() async {
        guard !query.isEmpty else {
            movies = .idle
            return
        }

        movies = .loading
        do {
            let results = try await searchMovieUseCase.execute(.init(query: query))
            movies = .success(result: results)
        } catch {
            movies = .failure(error: error)
        }
    }
}
