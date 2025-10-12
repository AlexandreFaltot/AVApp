//
//  MovieListViewController.swift
//  AVApp
//
//  Created by Alexandre Faltot on 09/10/2025.
//

import UIKit
import Combine


enum TextStyle: Int {
    case header1, header2, header3, paragraph

    var font: UIFont {
        return switch self {
        case .header1: .systemFont(ofSize: 28)
        case .header2: .systemFont(ofSize: 22)
        case .header3: .systemFont(ofSize: 18)
        case .paragraph: .systemFont(ofSize: 14)
        }
    }
}



class MovieListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private var cancellables: Set<AnyCancellable> = []

    var viewModel: MovieListViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerCell(ofType: AVTableViewCell<AVMovieCell>.self)
        tableView.delegate = self
        tableView.dataSource = self

        viewModel?.moviesPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] movies in
                print(movies)
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
        viewModel?.initialize()
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
        return viewModel?.fetchedMovies.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel,
              let movie = viewModel.movie(at: indexPath.row),
              let cell = tableView.dequeueReusableCell(ofType: AVTableViewCell<AVMovieCell>.self) else {
            return UITableViewCell()
        }

        cell.content.setup(with: movie)
        return cell
    }
}


#if DEBUG
import SwiftUI

#Preview("Error preview") {
    UIViewControllerPreview(controller: MovieListViewController())
}

#Preview("Empty list preview") {
    UIViewControllerPreview(controller: MovieListViewController())
}

#Preview("Normal preview") {
    UIViewControllerPreview(controller: MovieListViewController())
}
#endif
