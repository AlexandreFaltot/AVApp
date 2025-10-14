//
//  MDBCollection.swift
//  AVApp
//
//  Created by Alexandre Faltot on 13/10/2025.
//

import Foundation

struct MDBCollection: Codable {
    let id: Int
    let name: String
    let posterPath: String?
    let backdropPath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}
