//
//  Movie.swift
//  AVApp
//
//  Created by Alexandre Faltot on 10/10/2025.
//

import Foundation

struct AVMovie: Identifiable {
    let id: Int
    let title: String
    let posterFilePath: String?
    let releaseDate: Date?
    let genres: [String]
    let rating: Double
    let numberOfRatings: Int
    let synopsis: String
}

extension AVMovie {
    init(mdbMovie: MDBMovie, mdbGenres: [MDBGenre]) {
        self.id = mdbMovie.id
        self.title = mdbMovie.title
        self.posterFilePath = mdbMovie.posterPath
        self.releaseDate = mdbMovie.releaseDate
        self.genres = mdbMovie.genreIds
            .compactMap { id in
                mdbGenres.first { $0.id == id }?.name
            }
        self.rating = mdbMovie.voteAverage / 2
        self.numberOfRatings = mdbMovie.voteCount
        self.synopsis = mdbMovie.overview
    }

    init(mdbMovieDetails: MDBMovieDetails) {
        self.id = mdbMovieDetails.id
        self.title = mdbMovieDetails.title
        self.posterFilePath = mdbMovieDetails.posterPath
        self.releaseDate = mdbMovieDetails.releaseDate
        self.genres = mdbMovieDetails.genres.map { $0.name }
        self.rating = mdbMovieDetails.voteAverage / 2
        self.numberOfRatings = mdbMovieDetails.voteCount
        self.synopsis = mdbMovieDetails.overview
    }

    func posterUrl(_ size: MDBPosterSize) -> URL? {
        guard let posterFilePath else {
            return nil
        }

        return URL(string: "\(MDBConstants.baseImageUrl)/\(size.rawValue)\(posterFilePath)")
    }
}



#if DEBUG
extension AVMovie {
    static let mock: AVMovie = AVMovie(id: 0,
                                       title: "Title",
                                       posterFilePath: "/sprAGPxYPxLkcDqNK29SCGURTrp.jpg",
                                       releaseDate: Date(),
                                       genres: ["Thriller"],
                                       rating: 2.562,
                                       numberOfRatings: 60,
                                       synopsis: "Synopsis")
}

extension Collection where Element == AVMovie {
    static var mockTenMovies: [AVMovie] {
        (0..<10).map { index in
            AVMovie(id: index,
                    title: "Title \(index)",
                    posterFilePath: "/sprAGPxYPxLkcDqNK29SCGURTrp.jpg",
                    releaseDate: Date(),
                    genres: ["Genre \(index)"],
                    rating: 2.562,
                    numberOfRatings: 60,
                    synopsis: "Synopsis \(index)")
        }
    }
}
#endif
