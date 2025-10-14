//
//  ArrayTests.swift
//  AVApp
//
//  Created by Alexandre Faltot on 15/10/2025.
//


import Testing
import Foundation
@testable import AVApp

@MainActor
struct ArrayTests {
    @Test("safe subscript should return element when index is valid")
    func safeSubscriptShouldReturnElementWhenIndexIsValid() {
        // Given
        let array = [1, 2, 3, 4, 5]

        // When
        let result = array[safe: 2]

        // Then
        #expect(result == 3)
    }

    @Test("safe subscript should return nil when index is negative")
    func safeSubscriptShouldReturnNilWhenIndexIsNegative() {
        // Given
        let array = [1, 2, 3, 4, 5]

        // When
        let result = array[safe: -1]

        // Then
        #expect(result == nil)
    }

    @Test("safe subscript should return nil when index is out of bounds")
    func safeSubscriptShouldReturnNilWhenIndexIsOutOfBounds() {
        // Given
        let array = [1, 2, 3, 4, 5]

        // When
        let result = array[safe: 10]

        // Then
        #expect(result == nil)
    }

    @Test("safe subscript should return nil for empty array")
    func safeSubscriptShouldReturnNilForEmptyArray() {
        // Given
        let array: [Int] = []

        // When
        let result = array[safe: 0]

        // Then
        #expect(result == nil)
    }

    @Test("safe subscript should work with first element")
    func safeSubscriptShouldWorkWithFirstElement() {
        // Given
        let array = ["first", "second", "third"]

        // When
        let result = array[safe: 0]

        // Then
        #expect(result == "first")
    }

    @Test("safe subscript should work with last element")
    func safeSubscriptShouldWorkWithLastElement() {
        // Given
        let array = ["first", "second", "third"]

        // When
        let result = array[safe: 2]

        // Then
        #expect(result == "third")
    }
}
