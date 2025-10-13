//
//  AsyncView.swift
//  AVApp
//
//  Created by Alexandre Faltot on 09/10/2025.
//

import SwiftUI
import Foundation

extension EnvironmentValues {
    @Entry var allowRetry = true
    @Entry var displayErrorMessage = true
}

extension View {
    func allowRetry(_ value: Bool) -> some View {
        environment(\.allowRetry, value)
    }

    func displayErrorMessage(_ value: Bool) -> some View {
        environment(\.displayErrorMessage, value)
    }
}

struct AVAsyncView<T, Content: View>: View {
    // MARK: - Environment
    @Environment(\.allowRetry) private var allowRetry: Bool
    @Environment(\.displayErrorMessage) private var displayErrorMessage: Bool
    
    // MARK: - State
    @State private var asyncState: AsyncState<T> = .idle

    // MARK: - Properties
    private let content: (T) -> Content
    private let action: @MainActor @Sendable () async throws -> T

    // MARK: - Initialization
    init(
        action: @escaping @MainActor @Sendable () async throws -> T,
        @ViewBuilder content: @escaping (T) -> Content
    ) {
        self.content = content
        self.action = action
    }

    // MARK: - Body
    var body: some View {
        Group {
            switch asyncState {
            case .idle:
                ProgressView()
            case .success(let data):
                content(data)
            case .failure(let error):
                VStack {
                    if displayErrorMessage {
                        Text(.errorWithDescription(errorDescription: error.localizedDescription))
                    }
                    if allowRetry {
                        Button {
                            launchAction()
                        } label: {
                            Text(.retry)
                        }
                    }
                }
            }
        }
        .onLoad {
            launchAction()
        }
    }

    // MARK: - Methods
    func launchAction() {
        Task {
            asyncState = .idle
            do {
                let result = try await action()
                asyncState = .success(result: result)
            } catch {
                asyncState = .failure(error: error)
            }
        }
    }
}

#Preview("Loader with success") {
    AVAsyncView {
        try await Task.sleep(for: .seconds(3))
        return "Loaded"
    } content: { text in
        Text(text)
    }
}

#Preview("Loader with error") {
    AVAsyncView {
        try await Task.sleep(for: .seconds(1))
        throw OperationError.malformedUrl
    } content: {
        Text("Loaded")
    }
}
