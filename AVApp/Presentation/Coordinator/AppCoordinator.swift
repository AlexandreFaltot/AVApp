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

        let viewModel = MovieListViewModel()
        viewModel.onAskForMovieDetails = { [weak self] movie in
            self?.navigateToDetail(movie: movie)
        }
        viewModel.onAskForMovieSearch = { [weak self] in
            self?.navigateToSearch()
        }
        viewController.viewModel = viewModel
        navigationController.viewControllers = [viewController]
    }

    func navigateToDetail(movie: AVMovie) {
        let view = MovieDetailScreenView(viewModel: MovieDetailScreenViewModel(movieId: movie.id))
        let detail = AVUIHostingViewController(rootView: view)
        navigationController.pushViewController(detail, animated: true)
    }

    func navigateToSearch() {
        let viewModel = MovieSearchScreenViewModel()
        let view = MovieSearchScreenView(viewModel: viewModel,
                                         onAskForMovieDetails: { [weak self] in self?.navigateToDetail(movie: $0) })
        let detail = AVUIHostingViewController(rootView: view)
        navigationController.pushViewController(detail, animated: true)
    }
}
