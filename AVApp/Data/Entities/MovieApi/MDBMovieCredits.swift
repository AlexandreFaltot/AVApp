//
//  MDBMovieCredits.swift
//  AVApp
//
//  Created by Alexandre Faltot on 13/10/2025.
//

import Foundation

struct MDBMovieCredits: Decodable {
    let id: Int
    let cast: [MDBCastMember]
    let crew: [MDBCrewMember]
}
