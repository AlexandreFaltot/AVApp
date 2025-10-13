//
//  MDBProductionCompany.swift
//  AVApp
//
//  Created by Alexandre Faltot on 13/10/2025.
//


import Foundation

struct MDBProductionCompany: Codable {
    let id: Int
    let logoPath: String?
    let name: String
    let originCountry: String

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}