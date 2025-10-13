//
//  Movie.swift
//  AVApp
//
//  Created by Alexandre Faltot on 10/10/2025.
//

import Foundation

struct AVMovie {
    let id: Int
    let title: String
    let posterUrl: String?
    let releaseDate: Date
    let genres: [String]
    let rating: Double
    let numberOfRatings: Int
    let synopsis: String
}

extension AVMovie {
    init(mdbMovie: MDBMovie, mdbGenres: [MDBGenre]) {
        self.id = mdbMovie.id
        self.title = mdbMovie.title
        self.posterUrl = mdbMovie.posterPath.map { "https://image.tmdb.org/t/p/w500\($0)" }  
        self.releaseDate = mdbMovie.releaseDate
        self.genres = mdbMovie.genreIds
            .compactMap { id in
                mdbGenres.first { $0.id == id }?.name
            }
        self.rating = mdbMovie.voteAverage / 2
        self.numberOfRatings = mdbMovie.voteCount
        self.synopsis = mdbMovie.overview
    }
}

#if DEBUG
extension AVMovie {
    static let mock: AVMovie = AVMovie(id: 0,
                                       title: "Title",
                                       posterUrl: nil,
                                       releaseDate: Date(),
                                       genres: ["Thriller"],
                                       rating: 2.256,
                                       numberOfRatings: 60,
                                       synopsis: "Synopsis")
}

extension Collection where Element == AVMovie {
    static var mockTenMovies: [AVMovie] {
        (0..<10).map { _ in AVMovie.mock }
    }
}
#endif
