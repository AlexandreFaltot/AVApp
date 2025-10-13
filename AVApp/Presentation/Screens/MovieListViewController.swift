//
//  MovieListViewController.swift
//  AVApp
//
//  Created by Alexandre Faltot on 09/10/2025.
//

import UIKit
import Combine

class MovieListViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var retryView: AVUIRetryView!
    @IBOutlet weak var tableView: UITableView!

    lazy var tableFooterView: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.tintColor = .avWhite
        return activityIndicator
    }()

    lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        return control
    }()

    private let scrollOffsetThresoldForNewItems: CGFloat = 500
    private var cancellables: Set<AnyCancellable> = []
    private var isFetchingMoreMovies: Bool = false

    var viewModel: (any MovieListViewModelProtocol)?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindData()
    }

    func setupView() {
        refreshControl.tintColor = .avWhite
        retryView.onAskForRetry = { [weak self] in
            self?.viewModel?.refreshMovies()
        }

        tableView.registerCell(ofType: AVUIMovieTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = refreshControl

        tableView.tableFooterView = tableFooterView
    }

    func bindData() {
        viewModel?.moviesPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] state in
                guard let self,
                      let viewModel = self.viewModel else {
                    return
                }

                self.retryView.isHidden = !viewModel.shouldShowRetry
                self.tableView.isHidden = !viewModel.shouldShowMovies
                self.activityIndicator.isHidden = !viewModel.shouldShowLoading
                self.tableFooterView.stopAnimating()

                switch state {
                case .idle:
                    self.activityIndicator.startAnimating()
                case .success:
                    self.activityIndicator.stopAnimating()
                    self.refreshControl.endRefreshing()
                    self.tableView.reloadData()
                case .failure:
                    break
                }

                self.isFetchingMoreMovies = false
            }
            .store(in: &cancellables)
        viewModel?.initialize()
    }

    @IBAction func refresh(_ sender: UIRefreshControl) {
        viewModel?.refreshMovies()
    }
}

// MARK: - UITableViewDelegate methods
extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.askForMovieDetails(at: indexPath.row)
    }
}

// MARK: - UITableViewDataSource methods
extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.nbOfMovies ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel,
              let movie = viewModel.movie(at: indexPath.row),
              let cell = tableView.dequeueReusableCell(ofType: AVUIMovieTableViewCell.self) else {
            return UITableViewCell()
        }

        cell.setup(with: movie)
        return cell
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height

        // Trigger loading when user scrolls near the bottom
        if offsetY > contentHeight - height - scrollOffsetThresoldForNewItems, !isFetchingMoreMovies {
            tableFooterView.startAnimating()
            isFetchingMoreMovies = true
            viewModel?.getNextMovies()
        }
    }

}

#if DEBUG
import SwiftUI

#Preview("MovieListViewController preview") {
    UIViewControllerPreview(controller: {
        let viewController = MovieListViewController.instanceFromStoryboard()
        viewController?.viewModel = MockMovieListViewModel()
        return viewController ?? UIViewController()
    }())
}
#endif
