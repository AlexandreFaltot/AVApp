//
//  Container.swift
//  AVApp
//
//  Created by Alexandre Faltot on 14/10/2025.
//


protocol Container {
    func register<T>(_ type: T.Type, _ registration: @escaping (Self) throws -> T) rethrows
    func resolve<T>(_ type: T.Type) throws -> T
}

extension Container {
    subscript<T>(type: T.Type) -> T? {
        try? resolve(type)
    }
}

final class SingleContainer: Container {
    private var container = [String: Any]()

    func register<T>(_ type: T.Type, _ registration: @escaping (SingleContainer) throws -> T) rethrows {
        container[String(describing: type)] = try? registration(self)
    }

    func resolve<T>(_ type: T.Type) throws -> T {
        guard let value = container[String(describing: type)] as? T else {
            throw ContainerError.unableToResolve(type)
        }
        return value
    }
}

final class InstanceContainer: Container {
    private var container = [String: Any]()

    func register<T>(_ type: T.Type, _ registration: @escaping (InstanceContainer) throws -> T) rethrows {
        container[String(describing: type)] = registration
    }

    func resolve<T>(_ type: T.Type) throws -> T {
        guard let value = container[String(describing: type)] as? (InstanceContainer) throws -> T else {
            throw ContainerError.unableToResolve(type)
        }

        return try value(self)
    }
}

enum ContainerError<T>: Error {
    case unableToResolve(_ type: T.Type)
}
