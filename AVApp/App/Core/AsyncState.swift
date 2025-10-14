//
//  AsyncState.swift
//  AVApp
//
//  Created by Alexandre Faltot on 10/10/2025.
//

enum AsyncState<T> {
    case idle
    case loading
    case success(result: T)
    case failure(error: Error)

    var result: T? {
        guard case let .success(result) = self else {
            return nil
        }

        return result
    }

    var isSuccess: Bool {
        guard case .success = self else { return false }
        return true
    }

    var isIdle: Bool {
        guard case .idle = self else { return false }
        return true
    }

    var isLoading: Bool {
        guard case .loading = self else { return false }
        return true
    }

    var isFailure: Bool {
        guard case .failure = self else { return false }
        return true
    }
}
