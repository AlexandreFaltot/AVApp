//
//  MovieResponse.swift
//  AVApp
//
//  Created by Alexandre Faltot on 09/10/2025.
//

import Foundation

struct MDBMovieResponse: Decodable {
    let page: Int
    let results: [MDBMovie]
    let totalPages: Int
    let totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
