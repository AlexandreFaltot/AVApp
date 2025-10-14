//
//  MDBCastMemberArrayExtensionTests.swift
//  AVApp
//
//  Created by Alexandre Faltot on 15/10/2025.
//


import Testing
import Foundation
@testable import AVApp

@MainActor
struct MDBCastMemberArrayExtensionTests {
    @Test("knownForActing should filter cast members with acting department")
    func knownForActingShouldFilterCastMembersWithActingDepartment() {
        // Given
        let actingMember = MDBCastMember(
            adult: false,
            gender: 1,
            id: 1,
            knownForDepartment: "Acting",
            name: "Actor One",
            originalName: "Actor One",
            popularity: 10.0,
            profilePath: nil,
            castId: 1,
            character: "Character",
            creditId: "credit1",
            order: 1
        )
        let nonActingMember = MDBCastMember(
            adult: false,
            gender: 2,
            id: 2,
            knownForDepartment: "Directing",
            name: "Director One",
            originalName: "Director One",
            popularity: 8.0,
            profilePath: nil,
            castId: 2,
            character: "Character",
            creditId: "credit2",
            order: 2
        )
        let cast = [actingMember, nonActingMember]

        // When
        let result = cast.knownForActing

        // Then
        #expect(result.count == 1)
        #expect(result.first?.id == 1)
    }

    @Test("knownForActing should return empty array when no actors present")
    func knownForActingShouldReturnEmptyArrayWhenNoActorsPresent() {
        // Given
        let nonActingMember = MDBCastMember(
            adult: false,
            gender: 2,
            id: 2,
            knownForDepartment: "Directing",
            name: "Director One",
            originalName: "Director One",
            popularity: 8.0,
            profilePath: nil,
            castId: 2,
            character: "Character",
            creditId: "credit2",
            order: 2
        )
        let cast = [nonActingMember]

        // When
        let result = cast.knownForActing

        // Then
        #expect(result.isEmpty)
    }

    @Test("knownForActing should return all members when all are actors")
    func knownForActingShouldReturnAllMembersWhenAllAreActors() {
        // Given
        let actor1 = MDBCastMember(
            adult: false,
            gender: 1,
            id: 1,
            knownForDepartment: "Acting",
            name: "Actor One",
            originalName: "Actor One",
            popularity: 10.0,
            profilePath: nil,
            castId: 1,
            character: "Character 1",
            creditId: "credit1",
            order: 1
        )
        let actor2 = MDBCastMember(
            adult: false,
            gender: 2,
            id: 2,
            knownForDepartment: "Acting",
            name: "Actor Two",
            originalName: "Actor Two",
            popularity: 9.0,
            profilePath: nil,
            castId: 2,
            character: "Character 2",
            creditId: "credit2",
            order: 2
        )
        let cast = [actor1, actor2]

        // When
        let result = cast.knownForActing

        // Then
        #expect(result.count == 2)
    }
}
