//
//  ContainerTests.swift
//  AVApp
//
//  Created by Alexandre Faltot on 15/10/2025.
//

import Testing
import Foundation
@testable import AVApp

struct ContainerTests {

    // MARK: - SingleContainer Tests

    @Test("SingleContainer should resolve the same instance every time")
    func singleContainerShouldResolveSameInstance() throws {
        // Given
        let container = SingleContainer()

        // When
        container.register(ServiceA.self) { _ in ServiceA() }
        let instance1 = try container.resolve(ServiceA.self)
        let instance2 = try container.resolve(ServiceA.self)

        // Then
        #expect(instance1 == instance2)
    }

    @Test("SingleContainer should throw error when dependency is not registered")
    func singleContainerShouldThrowWhenNotRegistered() {
        // Given
        let container = SingleContainer()

        // When/Then
        #expect(throws: Error.self) {
            try container.resolve(ServiceA.self)
        }
    }

    // MARK: - InstanceContainer Tests

    @Test("InstanceContainer should create a new instance every time")
    func instanceContainerShouldCreateNewInstance() throws {
        // Given
        let container = InstanceContainer()

        // When
        container.register(ServiceA.self) { _ in ServiceA() }
        let instance1 = try container.resolve(ServiceA.self)
        let instance2 = try container.resolve(ServiceA.self)

        // Then
        #expect(instance1 != instance2)
    }

    @Test("InstanceContainer should resolve dependency with internal dependencies")
    func instanceContainerShouldResolveWithInternalDependencies() throws {
        // Given
        let container = InstanceContainer()

        // When
        container.register(ServiceA.self) { _ in ServiceA() }
        try container.register(ServiceB.self) { c in
            let a = try c.resolve(ServiceA.self)
            return ServiceB(serviceA: a)
        }

        let resolvedB = try? container.resolve(ServiceB.self)

        // Then
        #expect(resolvedB?.serviceA != nil)
    }

    @Test("InstanceContainer should throw error when dependency is not registered")
    func instanceContainerShouldThrowWhenNotRegistered() {
        // Given
        let container = InstanceContainer()

        // When/Then
        #expect(throws: Error.self) {
            try container.resolve(ServiceB.self)
        }
    }
}


// MARK: - Supporting Types
fileprivate struct ServiceA: Equatable {
    let id = UUID()
}

fileprivate struct ServiceB {
    let serviceA: ServiceA
}

