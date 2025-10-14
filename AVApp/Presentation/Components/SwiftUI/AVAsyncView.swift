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
    @State private var internalAsyncState: AsyncState<T> = .idle

    // MARK: - Properties
    private let content: (T) -> Content
    private let action: (@MainActor @Sendable () async throws -> T)?
    private let externalState: AsyncState<T>?
    private let onRetry: (() -> Void)?
    private var asyncState: AsyncState<T> {
        externalState ?? internalAsyncState
    }

    // MARK: - Initialization

    init(
        action: @escaping @MainActor @Sendable () async throws -> T,
        @ViewBuilder content: @escaping (T) -> Content
    ) {
        self.content = content
        self.action = action
        self.externalState = nil
        self.onRetry = nil
    }

    init(
        state: AsyncState<T>,
        onRetry: @escaping () -> Void,
        @ViewBuilder content: @escaping (T) -> Content
    ) {
        self.content = content
        self.action = nil
        self.externalState = state
        self.onRetry = onRetry
    }

    // MARK: - Body
    var body: some View {
        Group {
            switch asyncState {
            case .idle:
                Spacer()
            case .loading:
                ProgressView()
                    .tint(.avWhite)
            case .success(let data):
                content(data)
            case .failure(let error):
                VStack {
                    if displayErrorMessage {
                        Text(.errorWithDescription(errorDescription: error.localizedDescription))
                    }
                    if allowRetry {
                        Button {
                            handleRetry()
                        } label: {
                            Text(.retry)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.avYellow)
                    }
                }
                .avStyle(.paragraph)
            }
        }
        .onLoad {
            if action != nil {
                launchAction()
            }
        }
    }

    // MARK: - Methods
    private func handleRetry() {
        if let onRetry = onRetry {
            onRetry()
        } else {
            launchAction()
        }
    }

    private func launchAction() {
        guard let action = action else { return }

        Task { @MainActor in
            internalAsyncState = .loading
            do {
                let result = try await action()
                internalAsyncState = .success(result: result)
            } catch {
                internalAsyncState = .failure(error: error)
            }
        }
    }
}

#if DEBUG
#Preview("Loader with success") {
    VStack {
        AVAsyncView {
            try await Task.sleep(for: .seconds(1))
            return "Loaded"
        } content: { text in
            Text(text)
                .avStyle(.header2)
        }
        .frame(width: 375, height: 500)
    }
    .background(.avPrimary)
}

#Preview("Loader with error") {
    VStack {
        AVAsyncView {
            try await Task.sleep(for: .seconds(1))
            throw OperationError.malformedUrl
        } content: {
            Text("Loaded")
        }
        .frame(width: 375, height: 500)
    }
    .background(.avPrimary)
}
#endif
