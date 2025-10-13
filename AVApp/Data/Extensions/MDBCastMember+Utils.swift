//
//  MDBCastMember+Utils.swift
//  AVApp
//
//  Created by Alexandre Faltot on 13/10/2025.
//

private extension String {
    static let actingDepartment: String = "Acting"
}

extension Array where Element == MDBCastMember {
    var knownForActing: [MDBCastMember] {
        filter { $0.knownForDepartment == .actingDepartment }
    }
}
