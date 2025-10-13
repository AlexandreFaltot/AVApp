//
//  MDBSpokenLanguage.swift
//  AVApp
//
//  Created by Alexandre Faltot on 13/10/2025.
//


import Foundation

struct MDBSpokenLanguage: Codable {
    let englishName: String
    let iso639_1: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso639_1 = "iso_639_1"
        case name
    }
}