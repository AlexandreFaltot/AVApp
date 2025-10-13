//
//  AppCoordinator.swift
//  AVApp
//
//  Created by Alexandre Faltot on 09/10/2025.
//

import UIKit
import SwiftUI

final class AppCoordinator: Coordinator {
    // MARK: Public Properties
    let navigationController: UINavigationController

    // MARK: Initialization
    init(navigationController: UINavigationController = AVUINavigationController()) {
        self.navigationController = navigationController
        self.navigationController.isNavigationBarHidden = true
    }

    // MARK: Public Methods
    func start() {
        guard let viewController = MovieListViewController.instanceFromStoryboard() else {
            return
        }

        let viewModel = MovieListViewModel(getPopularMoviesUseCase: GetPopularMoviesUseCase())
        viewModel.onAskForMovieDetails = { [weak self] movie in
            self?.navigateToDetail(movie: movie)
        }
        viewController.viewModel = viewModel
        navigationController.viewControllers = [viewController]
    }
    
    func navigateToDetail(movie: AVMovie) {
        let view = MovieDetailView(viewModel: MovieDetailScreenViewModel(movieId: movie.id))
        let detail = AVUIHostingViewController(rootView: view)
        navigationController.pushViewController(detail, animated: true)
    }
}
