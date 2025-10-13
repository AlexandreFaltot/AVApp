//
//  MDBMovieDetails.swift
//  AVApp
//
//  Created by Alexandre Faltot on 13/10/2025.
//

import Foundation

struct MDBMovieDetails: Decodable {
    let adult: Bool
    let backdropPath: String?
    let belongsToCollection: MDBCollection?
    let budget: Int
    let genres: [MDBGenre]
    let homepage: String?
    let id: Int
    let imdbId: String?
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String?
    let productionCompanies: [MDBProductionCompany]
    let productionCountries: [MDBProductionCountry]
    let releaseDate: Date
    let revenue: Int
    let runtime: Int
    let spokenLanguages: [MDBSpokenLanguage]
    let status: String
    let tagline: String?
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case belongsToCollection = "belongs_to_collection"
        case budget
        case genres
        case homepage
        case id
        case imdbId = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue
        case runtime
        case spokenLanguages = "spoken_languages"
        case status
        case tagline
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.adult = try container.decode(.adult)
        self.backdropPath = try? container.decode(.backdropPath)
        self.belongsToCollection = try? container.decode(.belongsToCollection)
        self.budget = try container.decode(.budget)
        self.genres = try container.decode(.genres)
        self.homepage = try? container.decode(.homepage)
        self.id = try container.decode(.id)
        self.imdbId = try? container.decode(.imdbId)
        self.originalLanguage = try container.decode(.originalLanguage)
        self.originalTitle = try container.decode(.originalTitle)
        self.overview = try container.decode(.overview)
        self.popularity = try container.decode(.popularity)
        self.posterPath = try? container.decode(.posterPath)
        self.productionCompanies = try container.decode(.productionCompanies)
        self.productionCountries = try container.decode(.productionCountries)
        self.releaseDate = try container.decode(.releaseDate, using: .movieApiFormatter())
        self.revenue = try container.decode(.revenue)
        self.runtime = try container.decode(.runtime)
        self.spokenLanguages = try container.decode(.spokenLanguages)
        self.status = try container.decode(.status)
        self.tagline = try? container.decode(.tagline)
        self.title = try container.decode(.title)
        self.video = try container.decode(.video)
        self.voteAverage = try container.decode(.voteAverage)
        self.voteCount = try container.decode(.voteCount)
    }
}

