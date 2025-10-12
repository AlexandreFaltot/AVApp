//
//  AsyncView.swift
//  AVApp
//
//  Created by Alexandre Faltot on 09/10/2025.
//

import SwiftUI

struct AVAsyncView<T, Content: View>: View {
    // MARK: - Environment
    @Environment(\.allowRetry) private var allowRetry: Bool
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
                    Text("An error occured: \(error.localizedDescription)")
                    if allowRetry {
                        Button {
                            launchAction()
                        } label: {
                            Text("Retry")
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
