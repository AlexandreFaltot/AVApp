//
//  AVMovieHeadliner.swift
//  AVApp
//
//  Created by Alexandre Faltot on 13/10/2025.
//

import Foundation

struct AVMovieHeadliner: Identifiable, Hashable {
    let id: Int
    let characterName: String
    let name: String
    let imageUrl: URL?
}

extension AVMovieHeadliner {
    init(mdbCast: MDBCastMember) {
        self.id = mdbCast.id
        self.characterName = mdbCast.character
        self.name = mdbCast.name
        if let profilePath = mdbCast.profilePath {
            self.imageUrl = URL(string: MDBConstants.baseImageUrl + profilePath)
        } else {
            self.imageUrl = nil
        }
    }
}

#if DEBUG
extension AVMovieHeadliner {
    static let mock: AVMovieHeadliner = AVMovieHeadliner(id: 0,
                                                         characterName: "Character",
                                                         name: "Name",
                                                         imageUrl: nil)
}

extension Array where Element == AVMovieHeadliner {
    static var tenHeadlinersMock: [AVMovieHeadliner] { (0..<10).map { _ in AVMovieHeadliner.mock } }
}
#endif
