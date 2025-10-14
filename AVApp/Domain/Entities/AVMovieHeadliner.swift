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
    let profileImagePath: String?
}

extension AVMovieHeadliner {
    init(mdbCast: MDBCastMember) {
        self.id = mdbCast.id
        self.characterName = mdbCast.character
        self.name = mdbCast.name
        self.profileImagePath = mdbCast.profilePath
    }

    func profileImageUrl(_ size: MDBProfileSize) -> URL? {
        guard let profileImagePath else {
            return nil
        }

        return URL(string: "\(MDBConstants.baseImageUrl)/\(size.rawValue)\(profileImagePath)")
    }
}

#if DEBUG
extension AVMovieHeadliner {
    static let mock: AVMovieHeadliner = AVMovieHeadliner(id: 0,
                                                         characterName: "Character",
                                                         name: "Name",
                                                         profileImagePath: "/5Vs7huBmTKftwlsc2BPAntyaQYj.jpg")
}

extension Array where Element == AVMovieHeadliner {
    static var tenHeadlinersMock: [AVMovieHeadliner] { (0..<10).map { _ in AVMovieHeadliner.mock } }
}
#endif
