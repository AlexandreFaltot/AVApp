//
//  MDBCrewMemberArrayExtensionTests.swift
//  AVApp
//
//  Created by Alexandre Faltot on 15/10/2025.
//


import Testing
import Foundation
@testable import AVApp

@MainActor
struct MDBCrewMemberArrayExtensionTests {
    @Test("directors should filter crew members with director job")
    func directorsShouldFilterCrewMembersWithDirectorJob() {
        // Given
        let director = MDBCrewMember(
            adult: false,
            gender: 1,
            id: 1,
            knownForDepartment: "Directing",
            name: "Director One",
            originalName: "Director One",
            popularity: 10.0,
            profilePath: nil,
            creditId: "credit1",
            department: "Directing",
            job: "Director"
        )
        let producer = MDBCrewMember(
            adult: false,
            gender: 2,
            id: 2,
            knownForDepartment: "Production",
            name: "Producer One",
            originalName: "Producer One",
            popularity: 8.0,
            profilePath: nil,
            creditId: "credit2",
            department: "Production",
            job: "Producer"
        )
        let crew = [director, producer]

        // When
        let result = crew.directors

        // Then
        #expect(result.count == 1)
        #expect(result.first?.id == 1)
    }

    @Test("directors should return empty array when no directors present")
    func directorsShouldReturnEmptyArrayWhenNoDirectorsPresent() {
        // Given
        let producer = MDBCrewMember(
            adult: false,
            gender: 2,
            id: 2,
            knownForDepartment: "Production",
            name: "Producer One",
            originalName: "Producer One",
            popularity: 8.0,
            profilePath: nil,
            creditId: "credit2",
            department: "Production",
            job: "Producer"
        )
        let crew = [producer]

        // When
        let result = crew.directors

        // Then
        #expect(result.isEmpty)
    }

    @Test("directors should return multiple directors correctly")
    func directorsShouldReturnMultipleDirectorsCorrectly() {
        // Given
        let director1 = MDBCrewMember(
            adult: false,
            gender: 1,
            id: 1,
            knownForDepartment: "Directing",
            name: "Director One",
            originalName: "Director One",
            popularity: 10.0,
            profilePath: nil,
            creditId: "credit1",
            department: "Directing",
            job: "Director"
        )
        let director2 = MDBCrewMember(
            adult: false,
            gender: 2,
            id: 2,
            knownForDepartment: "Directing",
            name: "Director Two",
            originalName: "Director Two",
            popularity: 9.0,
            profilePath: nil,
            creditId: "credit2",
            department: "Directing",
            job: "Director"
        )
        let crew = [director1, director2]

        // When
        let result = crew.directors

        // Then
        #expect(result.count == 2)
    }
}