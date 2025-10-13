//
//  MDBProductionCountry.swift
//  AVApp
//
//  Created by Alexandre Faltot on 13/10/2025.
//


import Foundation

struct MDBProductionCountry: Codable {
    let iso3166_1: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
}