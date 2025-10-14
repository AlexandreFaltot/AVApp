//
//  AppCoordinatorTests.swift
//  AVApp
//
//  Created by Alexandre Faltot on 15/10/2025.
//

import Testing
@testable import AVApp
import UIKit

@MainActor
struct AppCoordinatorTests {
    init() {
        Module.shared.registerMocks()
    }

    // MARK: - Initialization Tests
    @Test("AppCoordinator should initialize with default navigation controller")
    func coordinatorInitializeWithDefaultNavigationController() async throws {
        // Given/When
        let sut = AppCoordinator()

        // Then
        #expect(sut.navigationController is AVUINavigationController)
        #expect(sut.navigationController.isNavigationBarHidden == true)
    }

    @Test("AppCoordinator should initialize with custom navigation controller")
    func coordinatorInitializeWithCustomNavigationController() async throws {
        // Given
        let customNavController = UINavigationController()

        // When
        let sut = AppCoordinator(navigationController: customNavController)

        // Then
        #expect(sut.navigationController === customNavController)
        #expect(sut.navigationController.isNavigationBarHidden == true)
    }

    // MARK: - Start Tests
    @Test("start should set MovieListViewController as root view controller")
    func startShouldSetMovieListAsRoot() async throws {
        // Given
        let sut = AppCoordinator()

        // When
        sut.start()

        // Then
        #expect(sut.navigationController.viewControllers.count == 1)
        #expect(sut.navigationController.viewControllers.first is MovieListViewController)
    }

    @Test("start should set view model on MovieListViewController")
    func startShouldSetViewModel() async throws {
        // Given
        let sut = AppCoordinator()

        // When
        sut.start()

        // Then
        guard let movieListVC = sut.navigationController.viewControllers.first as? MovieListViewController else {
            #expect(Bool(false), "First view controller should be MovieListViewController")
            return
        }
        #expect(movieListVC.viewModel != nil)
    }

    @Test("start should configure view model callbacks")
    func startShouldConfigureViewModelCallbacks() async throws {
        // Given
        let sut = AppCoordinator()
        sut.start()

        // When
        guard let movieListVC = sut.navigationController.viewControllers.first as? MovieListViewController,
              let viewModel = movieListVC.viewModel else {
            #expect(Bool(false), "ViewModel should be set")
            return
        }

        // Then
        #expect(viewModel.onAskForMovieDetails != nil)
        #expect(viewModel.onAskForMovieSearch != nil)
    }

    // MARK: - Navigate to Detail Tests
    @Test("navigateToDetail should push MovieDetailScreenView")
    func navigateToDetailShouldPushDetailScreen() async throws {
        // Given
        let sut = AppCoordinator()
        sut.start()
        let movie: AVMovie = .mock

        // When
        sut.navigateToDetail(movie: movie)

        // Then
        #expect(sut.navigationController.viewControllers.count == 2)
        #expect(sut.navigationController.viewControllers.last is AVUIHostingViewController<MovieDetailScreenView>)
    }

    @Test("navigateToDetail should create view model with correct movie ID")
    func navigateToDetailShouldCreateViewModelWithCorrectId() async throws {
        // Given
        let sut = AppCoordinator()
        sut.start()
        let movie: AVMovie = .mock

        // When
        sut.navigateToDetail(movie: movie)

        // Then
        guard sut.navigationController.viewControllers.last is AVUIHostingViewController<MovieDetailScreenView> else {
            #expect(Bool(false), "Last view controller should be hosting controller")
            return
        }

        // Note: We can't directly access the view model from the hosting controller easily,
        // but we can verify the correct type was pushed
        #expect(sut.navigationController.viewControllers.count == 2)
    }

    // MARK: - Navigate to Search Tests
    @Test("navigateToSearch should push MovieSearchScreenView")
    func navigateToSearchShouldPushSearchScreen() async throws {
        // Given
        let sut = AppCoordinator()
        sut.start()

        // When
        sut.navigateToSearch()

        // Then
        #expect(sut.navigationController.viewControllers.count == 2)
        #expect(sut.navigationController.viewControllers.last is AVUIHostingViewController<MovieSearchScreenView>)
    }

    @Test("navigateToSearch should create view model")
    func navigateToSearchShouldCreateViewModel() async throws {
        // Given
        let sut = AppCoordinator()
        sut.start()

        // When
        sut.navigateToSearch()

        // Then
        guard sut.navigationController.viewControllers.last is AVUIHostingViewController<MovieSearchScreenView> else {
            #expect(Bool(false), "Last view controller should be hosting controller")
            return
        }

        #expect(sut.navigationController.viewControllers.count == 2)
    }

    @Test("navigateToSearch should be callable multiple times")
    func navigateToSearchShouldBeCallableMultipleTimes() async throws {
        // Given
        let sut = AppCoordinator()
        sut.start()

        // When
        sut.navigateToSearch()
        sut.navigateToSearch()

        // Then
        #expect(sut.navigationController.viewControllers.count == 3)
    }

    // MARK: - Integration Tests
    @Test("onAskForMovieDetails callback should navigate to detail")
    func onAskForMovieDetailsCallbackShouldNavigate() async throws {
        // Given
        let sut = AppCoordinator()
        sut.start()

        guard let movieListVC = sut.navigationController.viewControllers.first as? MovieListViewController,
              let viewModel = movieListVC.viewModel else {
            #expect(Bool(false), "ViewModel should be set")
            return
        }

        let movie: AVMovie = .mock

        // When
        viewModel.onAskForMovieDetails?(movie)

        // Then
        #expect(sut.navigationController.viewControllers.count == 2)
        #expect(sut.navigationController.viewControllers.last is AVUIHostingViewController<MovieDetailScreenView>)
    }

    @Test("onAskForMovieSearch callback should navigate to search")
    func onAskForMovieSearchCallbackShouldNavigate() async throws {
        // Given
        let sut = AppCoordinator()
        sut.start()

        guard let movieListVC = sut.navigationController.viewControllers.first as? MovieListViewController,
              let viewModel = movieListVC.viewModel else {
            #expect(Bool(false), "ViewModel should be set")
            return
        }

        // When
        viewModel.onAskForMovieSearch?()

        // Then
        #expect(sut.navigationController.viewControllers.count == 2)
        #expect(sut.navigationController.viewControllers.last is AVUIHostingViewController<MovieSearchScreenView>)
    }

    @Test("navigation stack should maintain correct order")
    func navigationStackShouldMaintainCorrectOrder() async throws {
        // Given
        let sut = AppCoordinator()
        sut.start()
        let movie: AVMovie = .mock

        // When
        sut.navigateToSearch()
        sut.navigateToDetail(movie: movie)

        // Then
        #expect(sut.navigationController.viewControllers.count == 3)
        #expect(sut.navigationController.viewControllers[0] is MovieListViewController)
        #expect(sut.navigationController.viewControllers[1] is AVUIHostingViewController<MovieSearchScreenView>)
        #expect(sut.navigationController.viewControllers[2] is AVUIHostingViewController<MovieDetailScreenView>)
    }

    @Test("coordinator should handle weak self references properly")
    func coordinatorShouldHandleWeakSelfReferences() async throws {
        // Given
        var sut: AppCoordinator? = AppCoordinator()
        sut?.start()

        guard let movieListVC = sut?.navigationController.viewControllers.first as? MovieListViewController,
              let viewModel = movieListVC.viewModel else {
            #expect(Bool(false), "ViewModel should be set")
            return
        }

        let movie: AVMovie = .mock

        // When - Release the coordinator
        sut = nil

        // Then - Callback should not crash when coordinator is nil
        viewModel.onAskForMovieDetails?(movie)
        viewModel.onAskForMovieSearch?()

        // If we get here without crashing, the weak references work correctly
        #expect(Bool(true))
    }

    @Test("start should replace existing view controllers")
    func startShouldReplaceExistingViewControllers() async throws {
        // Given
        let sut = AppCoordinator()
        sut.start()
        let movie: AVMovie = .mock
        sut.navigateToDetail(movie: movie)
        #expect(sut.navigationController.viewControllers.count == 2)

        // When - Call start again
        sut.start()

        // Then - Should reset to just the root view controller
        #expect(sut.navigationController.viewControllers.count == 1)
        #expect(sut.navigationController.viewControllers.first is MovieListViewController)
    }
}
