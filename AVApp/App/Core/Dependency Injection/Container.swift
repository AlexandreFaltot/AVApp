//
//  Container.swift
//  AVApp
//
//  Created by Alexandre Faltot on 14/10/2025.
//

protocol Container {
    ///
    /// Registers a dependency for the container
    ///
    /// - Parameters:
    ///   - type: The type of the dependency to register
    ///   - registration: The method that will be triggered for the registration
    ///
    func register<T>(_ type: T.Type, _ registration: @escaping (Self) throws -> T) rethrows

    ///
    /// Gives a registered dependency
    ///
    /// - Parameters:
    ///   - type: The type of the dependency to resolve
    ///
    func resolve<T>(_ type: T.Type) throws -> T
}

extension Container {
    subscript<T>(type: T.Type) -> T? {
        try? resolve(type)
    }
}

final class SingleContainer: Container {
    private var container = [ObjectIdentifier: Any]()

    func register<T>(_ type: T.Type, _ registration: @escaping (SingleContainer) throws -> T) rethrows {
        container[ObjectIdentifier(type)] = try? registration(self)
    }

    func resolve<T>(_ type: T.Type) throws -> T {
        guard let value = container[ObjectIdentifier(type)] as? T else {
            throw ContainerError.unableToResolve(type)
        }
        return value
    }
}

final class InstanceContainer: Container {
    private var container = [ObjectIdentifier: Any]()

    func register<T>(_ type: T.Type, _ registration: @escaping (InstanceContainer) throws -> T) rethrows {
        container[ObjectIdentifier(type)] = registration
    }

    func resolve<T>(_ type: T.Type) throws -> T {
        guard let value = container[ObjectIdentifier(type)] as? (InstanceContainer) throws -> T else {
            throw ContainerError.unableToResolve(type)
        }

        return try value(self)
    }
}

enum ContainerError<T>: Error {
    case unableToResolve(_ type: T.Type)
}
