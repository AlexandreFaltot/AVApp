//
//  AVTextStyleTests.swift
//  AVApp
//
//  Created by Alexandre Faltot on 15/10/2025.
//


import Testing
import Foundation
@testable import AVApp

@MainActor
struct AVTextStyleTests {
    @Test("header1 should have correct font size")
    func header1ShouldHaveCorrectFontSize() {
        // Given
        let style = AVTextStyle.header1

        // When
        let fontSize = style.fontSize

        // Then
        #expect(fontSize == 28)
    }

    @Test("header2 should have correct font size")
    func header2ShouldHaveCorrectFontSize() {
        // Given
        let style = AVTextStyle.header2

        // When
        let fontSize = style.fontSize

        // Then
        #expect(fontSize == 22)
    }

    @Test("header3 should have correct font size")
    func header3ShouldHaveCorrectFontSize() {
        // Given
        let style = AVTextStyle.header3

        // When
        let fontSize = style.fontSize

        // Then
        #expect(fontSize == 18)
    }

    @Test("paragraph should have correct font size")
    func paragraphShouldHaveCorrectFontSize() {
        // Given
        let style = AVTextStyle.paragraph

        // When
        let fontSize = style.fontSize

        // Then
        #expect(fontSize == 16)
    }

    @Test("paragraphBold should have correct font size")
    func paragraphBoldShouldHaveCorrectFontSize() {
        // Given
        let style = AVTextStyle.paragraphBold

        // When
        let fontSize = style.fontSize

        // Then
        #expect(fontSize == 16)
    }

    @Test("smallParagraph should have correct font size")
    func smallParagraphShouldHaveCorrectFontSize() {
        // Given
        let style = AVTextStyle.smallParagraph

        // When
        let fontSize = style.fontSize

        // Then
        #expect(fontSize == 14)
    }

    @Test("smallParagraphBold should have correct font size")
    func smallParagraphBoldShouldHaveCorrectFontSize() {
        // Given
        let style = AVTextStyle.smallParagraphBold

        // When
        let fontSize = style.fontSize

        // Then
        #expect(fontSize == 14)
    }

    @Test("caption should have correct font size")
    func captionShouldHaveCorrectFontSize() {
        // Given
        let style = AVTextStyle.caption

        // When
        let fontSize = style.fontSize

        // Then
        #expect(fontSize == 14)
    }
}
