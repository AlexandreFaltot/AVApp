//
//  AsyncView.swift
//  AVApp
//
//  Created by Alexandre Faltot on 09/10/2025.
//

import SwiftUI

enum AsyncState<T> {
    case idle
    case success(result: T)
    case error(error: Error)
}

struct AsyncView<T, Content: View>: View {
    @Environment(\.allowRetry) private var allowRetry: Bool
    @State private var asyncState: AsyncState<T> = .idle

    private let content: (T) -> Content
    private let action: @MainActor @Sendable () async throws -> T

    init(
        action: @escaping @MainActor @Sendable () async throws -> T,
        @ViewBuilder content: @escaping (T) -> Content
    ) {
        self.content = content
        self.action = action
    }

    var body: some View {
        Group {
            switch asyncState {
            case .idle:
                ProgressView()
            case .success(let data):
                content(data)
            case .error(let error):
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

    func launchAction() {
        Task {
            asyncState = .idle
            do {
                let result = try await action()
                asyncState = .success(result: result)
            } catch {
                asyncState = .error(error: error)
            }
        }
    }
}
