//
//  IntExtensionTests.swift
//  AVApp
//
//  Created by Alexandre Faltot on 15/10/2025.
//


import Testing
import Foundation
@testable import AVApp

@MainActor
struct IntExtensionTests {
    @Test("asHourFormat should format minutes less than 60 correctly")
    func asHourFormatShouldFormatMinutesLessThan60Correctly() {
        // Given
        let minutes = 45

        // When
        let result = minutes.asHourFormat()

        // Then
        #expect(result.contains("45"))
        #expect(result.contains("0"))
    }

    @Test("asHourFormat should format exactly one hour correctly")
    func asHourFormatShouldFormatExactlyOneHourCorrectly() {
        // Given
        let minutes = 60

        // When
        let result = minutes.asHourFormat()

        // Then
        #expect(result.contains("1"))
    }

    @Test("asHourFormat should format hours and minutes correctly")
    func asHourFormatShouldFormatHoursAndMinutesCorrectly() {
        // Given
        let minutes = 125 // 2 hours 5 minutes

        // When
        let result = minutes.asHourFormat()

        // Then
        #expect(result.contains("2"))
        #expect(result.contains("5"))
    }

    @Test("asHourFormat should format multiple hours correctly")
    func asHourFormatShouldFormatMultipleHoursCorrectly() {
        // Given
        let minutes = 180 // 3 hours

        // When
        let result = minutes.asHourFormat()

        // Then
        #expect(result.contains("3"))
    }

    @Test("asHourFormat should handle zero minutes correctly")
    func asHourFormatShouldHandleZeroMinutesCorrectly() {
        // Given
        let minutes = 0

        // When
        let result = minutes.asHourFormat()

        // Then
        #expect(result.contains("0"))
    }
}