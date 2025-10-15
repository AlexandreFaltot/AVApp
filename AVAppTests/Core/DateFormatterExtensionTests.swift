//
//  DateFormatterExtensionTests.swift
//  AVApp
//
//  Created by Alexandre Faltot on 15/10/2025.
//


import Testing
import Foundation
@testable import AVApp

@MainActor
struct DateFormatterExtensionTests {
    @Test("movieApiFormatter should return formatter with correct date format")
    func movieApiFormatterShouldReturnFormatterWithCorrectDateFormat() {
        // When
        let formatter = DateFormatter.movieApiFormatter()

        // Then
        #expect(formatter.dateFormat == "yyyy-MM-dd")
    }

    @Test("movieApiFormatter should parse date string correctly")
    func movieApiFormatterShouldParseDateStringCorrectly() {
        // Given
        let formatter = DateFormatter.movieApiFormatter()
        let dateString = "2024-03-15"

        // When
        let date = formatter.date(from: dateString)

        // Then
        #expect(date != nil)
    }

    @Test("movieApiFormatter should format date correctly")
    func movieApiFormatterShouldFormatDateCorrectly() throws {
        // Given
        let formatter = DateFormatter.movieApiFormatter()
        let calendar = Calendar.current
        let components = DateComponents(year: 2024, month: 3, day: 15)
        guard let date = calendar.date(from: components) else {
            throw DateFormatterTestError.wrongDate
        }

        // When
        let dateString = formatter.string(from: date)

        // Then
        #expect(dateString == "2024-03-15")
    }

    @Test("movieDateFormatter should return formatter with medium date style")
    func movieDateFormatterShouldReturnFormatterWithMediumDateStyle() {
        // When
        let formatter = DateFormatter.movieDateFormatter()

        // Then
        #expect(formatter.dateStyle == .medium)
    }
}

enum DateFormatterTestError: Error {
    case wrongDate
}
