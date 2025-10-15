//
//  MDBCrewMember+Utils.swift
//  AVApp
//
//  Created by Alexandre Faltot on 13/10/2025.
//

private extension String {
    static let jobDirector = "Director"
}

extension Array where Element == MDBCrewMember {
    /// Gives only the elements which ``MDBCrewMember.job`` are `"Director"`
    var directors: [MDBCrewMember] {
        filter { $0.job == .jobDirector }
    }
}
