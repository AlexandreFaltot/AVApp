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
    let posterFilePath: String?
    let backdropFilePath: String?
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
        self.posterFilePath = mdbMovieDetails.posterPath
        self.backdropFilePath = mdbMovieDetails.backdropPath
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

    func posterUrl(_ size: MDBPosterSize) -> URL? {
        guard let posterFilePath else {
            return nil
        }

        return URL(string: "\(MDBConstants.baseImageUrl)/\(size.rawValue)\(posterFilePath)")
    }

    func backdropUrl(_ size: MDBPosterSize) -> URL? {
        guard let backdropFilePath else {
            return nil
        }

        return URL(string: "\(MDBConstants.baseImageUrl)/\(size.rawValue)\(backdropFilePath)")
    }
}

#if DEBUG
extension AVMovieDetails {
    static let mock: AVMovieDetails = AVMovieDetails(id: 0,
                                                     title: "Title",
                                                     posterFilePath: "/CT7EhbB5yVLdUfvIiZs5QhOvgU.jpg",
                                                     backdropFilePath: "/9DYFYhmbXRGsMhfUgXM3VSP9uLX.jpg",
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
