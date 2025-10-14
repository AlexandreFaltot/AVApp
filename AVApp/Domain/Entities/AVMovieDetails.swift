//
//  Movie.swift
//  AVApp
//
//  Created by Alexandre Faltot on 10/10/2025.
//

import Foundation

struct AVMovieDetails {
    let id: Int
    let title: String
    let posterUrl: URL?
    let backdrop: URL?
    let runtime: Int
    let releaseDate: Date?
    let genres: [String]
    let rating: Double
    let numberOfRatings: Int
    let synopsis: String
    let headliners: [AVMovieHeadliner]
    let directors: [String]
}

extension AVMovieDetails {
    init(mdbMovieDetails: MDBMovieDetails, credits: MDBMovieCredits) {
        self.id = mdbMovieDetails.id
        self.title = mdbMovieDetails.title
        self.runtime = mdbMovieDetails.runtime
        if let posterPath = mdbMovieDetails.posterPath {
            self.posterUrl = URL(string: MDBConstants.baseImageUrl + posterPath)
        } else {
            self.posterUrl = nil
        }
        if let backdropPath = mdbMovieDetails.backdropPath {
            self.backdrop = URL(string: MDBConstants.baseImageUrl + backdropPath)
        } else {
            self.backdrop = nil
        }
        self.releaseDate = mdbMovieDetails.releaseDate
        self.genres = mdbMovieDetails.genres.map { $0.name }
        self.rating = mdbMovieDetails.voteAverage / 2
        self.numberOfRatings = mdbMovieDetails.voteCount
        self.synopsis = mdbMovieDetails.overview
        self.headliners = credits.cast.knownForActing
            .prefix(5)
            .map { AVMovieHeadliner(mdbCast: $0) }
        self.directors = credits.crew.directors.map(\.name)
    }
}

#if DEBUG
extension AVMovieDetails {
    static let mock: AVMovieDetails = AVMovieDetails(id: 0,
                                                     title: "Title",
                                                     posterUrl: URL(string: MDBConstants.baseImageUrl + "/CT7EhbB5yVLdUfvIiZs5QhOvgU.jpg"),
                                                     backdrop: URL(string: MDBConstants.baseImageUrl + "/9DYFYhmbXRGsMhfUgXM3VSP9uLX.jpg"),
                                                     runtime: 100,
                                                     releaseDate: Date(),
                                                     genres: ["Thriller"],
                                                     rating: 2.562,
                                                     numberOfRatings: 60,
                                                     synopsis: "Synopsis",
                                                     headliners: .tenHeadlinersMock,
                                                     directors: ["Director"])
}
#endif
