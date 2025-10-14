//
//  DoubleExtensionTests.swift
//  AVApp
//
//  Created by Alexandre Faltot on 15/10/2025.
//


import Testing
import Foundation
@testable import AVApp

@MainActor
struct DoubleExtensionTests {
    let separator: String = Locale.current.decimalSeparator ?? "."

    @Test("roundedTo1Decimal should format double with one decimal place")
    func roundedTo1DecimalShouldFormatDoubleWithOneDecimalPlace() {
        // Given
        let value = 7.8

        // When
        let result = value.roundedTo1Decimal

        // Then
        #expect(result == "7\(separator)8")
    }

    @Test("roundedTo1Decimal should round up correctly")
    func roundedTo1DecimalShouldRoundUpCorrectly() {
        // Given
        let value = 7.85

        // When
        let result = value.roundedTo1Decimal

        // Then
        #expect(result == "7\(separator)9")
    }

    @Test("roundedTo1Decimal should round down correctly")
    func roundedTo1DecimalShouldRoundDownCorrectly() {
        // Given
        let value = 7.84

        // When
        let result = value.roundedTo1Decimal

        // Then
        #expect(result == "7\(separator)8")
    }

    @Test("roundedTo1Decimal should format integer double with decimal")
    func roundedTo1DecimalShouldFormatIntegerDoubleWithDecimal() {
        // Given
        let value = 7.0

        // When
        let result = value.roundedTo1Decimal

        // Then
        #expect(result == "7\(separator)0")
    }

    @Test("roundedTo1Decimal should handle zero correctly")
    func roundedTo1DecimalShouldHandleZeroCorrectly() {
        // Given
        let value = 0.0

        // When
        let result = value.roundedTo1Decimal

        // Then
        #expect(result == "0\(separator)0")
    }
}
