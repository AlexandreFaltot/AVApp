//
//  Movie.swift
//  AVApp
//
//  Created by Alexandre Faltot on 09/10/2025.
//

import Foundation

struct MDBMovie: Decodable {
    let adult: Bool
    let backdropPath: String?
    let genreIds: [Int]
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate: Date?
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }

    init(adult: Bool, backdropPath: String?, genreIds: [Int], id: Int, originalLanguage: String, originalTitle: String, overview: String, popularity: Double, posterPath: String?, releaseDate: Date, title: String, video: Bool, voteAverage: Double, voteCount: Int) {
        self.adult = adult
        self.backdropPath = backdropPath
        self.genreIds = genreIds
        self.id = id
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.title = title
        self.video = video
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.adult = try container.decode(.adult)
        self.backdropPath = try? container.decode(.backdropPath)
        self.genreIds = try container.decode(.genreIds)
        self.id = try container.decode(.id)
        self.originalLanguage = try container.decode(.originalLanguage)
        self.originalTitle = try container.decode(.originalTitle)
        self.overview = try container.decode(.overview)
        self.popularity = try container.decode(.popularity)
        self.posterPath = try? container.decode(.posterPath)
        self.releaseDate = try? container.decode(.releaseDate, using: DateFormatter.movieApiFormatter())
        self.title = try container.decode(.title)
        self.video = try container.decode(.video)
        self.voteAverage = try container.decode(.voteAverage)
        self.voteCount = try container.decode(.voteCount)
    }
}
