//
//  MoculeTests.swift
//  AVApp
//
//  Created by Alexandre Faltot on 15/10/2025.
//


import Testing
import Foundation
@testable import AVApp

struct ModuleTests {
    @Test("Module should resolve same instance when using single scope")
    func moduleShouldResolveSameInstanceForSingleScope() {
        // Given
        let module = Module()
        module.register(ServiceA.self, in: \.single) { _ in ServiceA() }

        // When
        let instance1: ServiceA = module.resolve(scope: \.single)
        let instance2: ServiceA = module.resolve(scope: \.single)

        // Then
        #expect(instance1 == instance2)
    }

    @Test("Module should resolve new instance when using instance scope")
    func moduleShouldResolveNewInstanceForInstanceScope() {
        // Given
        let module = Module()
        module.register(ServiceA.self, in: \.instance) { _ in ServiceA() }

        // When
        let instance1: ServiceA = module.resolve(scope: \.instance)
        let instance2: ServiceA = module.resolve(scope: \.instance)

        // Then
        #expect(instance1 != instance2)
    }

    @Test("Module should resolve dependency with nested dependency in instance scope")
    func moduleShouldResolveDependencyWithNestedDependency() {
        // Given
        let module = Module()
        module.register(ServiceA.self, in: \.instance) { _ in ServiceA() }
        module.register(ServiceB.self, in: \.instance) { container in
            let a: ServiceA = try! container.resolve(ServiceA.self)
            return ServiceB(serviceA: a)
        }

        // When
        let a: ServiceA = module.resolve(scope: \.instance)
        let b: ServiceB = module.resolve(scope: \.instance)

        // Then
        #expect(b.serviceA != a)
    }
}

// MARK: - Supporting Types
fileprivate struct ServiceA: Equatable {
    let id = UUID()
}

fileprivate struct ServiceB {
    let serviceA: ServiceA
}
