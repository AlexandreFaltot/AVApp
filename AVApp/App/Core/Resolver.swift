//
//  Resolver.swift
//  AVApp
//
//  Created by Alexandre Faltot on 14/10/2025.
//


typealias Scope = KeyPath<Module, any Container>

final class Module {
    public static let shared = Module()

    let single: Container = SingleContainer()
    let instance: Container = InstanceContainer()

    ///
    /// Registers a dependency for a given container
    ///
    /// - Parameters:
    ///   - type: The type of the dependency to register
    ///   - container: The container that will receive the dependency
    ///   - dependency: The dependency to register
    ///
    func register<T>(_ type: T.Type = T.self, in scope: Scope = \.single, _ dependency: @escaping (Container) -> T) {
        self[keyPath: scope].register(type, dependency)
    }

    ///
    /// Resolves the depencendy for the given container
    ///
    /// - Parameter container: The container that will resolve the dependency
    /// - Returns: The found dependency
    ///
    func resolve<T>(scope: Scope = \.single) -> T {
        return try! self[keyPath: scope].resolve(T.self)
    }
}

import Foundation

extension Module {
    func registerAppDependencies() {
        registerEngines()
        registerRepositories()
        registerUseCases()
    }

    private func registerEngines() {
        register(ImageCacheManager.self) { _ in ImageCacheManager() }
        register(NetworkCacheManager.self) { _ in NetworkCacheManager() }
        register(RestClientProtocol.self) { _ in RestClient(urlSession: .shared) }
    }

    private func registerRepositories() {
        register(GenreRepositoryProtocol.self) { _ in GenreRepository() }
        register(MovieRepositoryProtocol.self) { _ in MovieRepository() }
    }

    private func registerUseCases() {
        register((any GetPopularMoviesUseCaseProtocol).self, in: \.instance) { _ in GetPopularMoviesUseCase() }
        register((any GetMovieDetailsUseCaseProtocol).self, in: \.instance) { _ in GetMovieDetailsUseCase() }
        register((any SearchMoviesUseCaseProtocol).self, in: \.instance) { _ in SearchMoviesUseCase() }
    }

    #if DEBUG
    func registerPreviewsDependencies() {
        register(ImageCacheManager.self) { _ in ImageCacheManager() }
        register(NetworkCacheManager.self) { _ in NetworkCacheManager() }
        register(RestClientProtocol.self) { _ in RestClient(urlSession: .shared) }
    }
    #endif
}
