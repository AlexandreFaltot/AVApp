//
//  MDBCastMember.swift
//  AVApp
//
//  Created by Alexandre Faltot on 13/10/2025.
//


import Foundation

struct MDBCastMember: Decodable {
    let adult: Bool
    let gender: Int
    let id: Int
    let knownForDepartment: String
    let name: String
    let originalName: String
    let popularity: Double
    let profilePath: String?
    let castId: Int
    let character: String
    let creditId: String
    let order: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case gender
        case id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castId = "cast_id"
        case character
        case creditId = "credit_id"
        case order
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.adult = try container.decode(.adult)
        self.gender = try container.decode(.gender)
        self.id = try container.decode(.id)
        self.knownForDepartment = try container.decode(.knownForDepartment)
        self.name = try container.decode(.name)
        self.originalName = try container.decode(.originalName)
        self.popularity = try container.decode(.popularity)
        self.profilePath = try? container.decode(.profilePath)
        self.castId = try container.decode(.castId)
        self.character = try container.decode(.character)
        self.creditId = try container.decode(.creditId)
        self.order = try container.decode(.order)
    }
}