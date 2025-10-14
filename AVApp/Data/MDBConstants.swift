//
//  MDBConstants.swift
//  AVApp
//
//  Created by Alexandre Faltot on 13/10/2025.
//

import Foundation

struct MDBConstants {
    static let movieDBApiKey: String? = Bundle.main.infoDictionary?["MOVIE_DB_API_KEY"] as? String
    static let baseUrl: String = "https://api.themoviedb.org/3"
    static let baseImageUrl: String = "https://image.tmdb.org/t/p"
}
