//
//  AsyncStateTests.swift
//  AVApp
//
//  Created by Alexandre Faltot on 15/10/2025.
//

import Testing
import Foundation
@testable import AVApp

@MainActor
struct AsyncStateTests {
    // MARK: - Initialize Tests
    @Test("AsyncState should initialize in idle state")
    func asyncStateShouldInitializeInIdleState() {
        // Given/When
        let sut: AsyncState<String> = .idle

        // Then
        #expect(sut.isIdle)
        #expect(!sut.isLoading)
        #expect(!sut.isSuccess)
        #expect(!sut.isFailure)
        #expect(sut.result == nil)
    }

    @Test("AsyncState should initialize in loading state")
    func asyncStateShouldInitializeInLoadingState() {
        // Given/When
        let sut: AsyncState<String> = .loading

        // Then
        #expect(sut.isLoading)
        #expect(!sut.isIdle)
        #expect(!sut.isSuccess)
        #expect(!sut.isFailure)
        #expect(sut.result == nil)
    }

    @Test("AsyncState should initialize in success state with result")
    func asyncStateShouldInitializeInSuccessStateWithResult() {
        // Given
        let expectedResult = "Success Data"

        // When
        let sut: AsyncState<String> = .success(result: expectedResult)

        // Then
        #expect(sut.isSuccess)
        #expect(!sut.isIdle)
        #expect(!sut.isLoading)
        #expect(!sut.isFailure)
        #expect(sut.result == expectedResult)
    }

    @Test("AsyncState should initialize in failure state with error")
    func asyncStateShouldInitializeInFailureStateWithError() {
        // Given
        struct TestError: Error {}
        let error = TestError()

        // When
        let sut: AsyncState<String> = .failure(error: error)

        // Then
        #expect(sut.isFailure)
        #expect(!sut.isIdle)
        #expect(!sut.isLoading)
        #expect(!sut.isSuccess)
        #expect(sut.result == nil)
    }

    // MARK: - Result Property Tests
    @Test("result should return nil for idle state")
    func resultShouldReturnNilForIdleState() {
        // Given
        let sut: AsyncState<Int> = .idle

        // When
        let result = sut.result

        // Then
        #expect(result == nil)
    }

    @Test("result should return nil for loading state")
    func resultShouldReturnNilForLoadingState() {
        // Given
        let sut: AsyncState<Int> = .loading

        // When
        let result = sut.result

        // Then
        #expect(result == nil)
    }

    @Test("result should return nil for failure state")
    func resultShouldReturnNilForFailureState() {
        // Given
        struct TestError: Error {}
        let sut: AsyncState<Int> = .failure(error: TestError())

        // When
        let result = sut.result

        // Then
        #expect(result == nil)
    }

    @Test("result should return value for success state")
    func resultShouldReturnValueForSuccessState() {
        // Given
        let expectedValue = 42
        let sut: AsyncState<Int> = .success(result: expectedValue)

        // When
        let result = sut.result

        // Then
        #expect(result == expectedValue)
    }
}
