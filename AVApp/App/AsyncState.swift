//
//  AsyncState.swift
//  AVApp
//
//  Created by Alexandre Faltot on 10/10/2025.
//


enum AsyncState<T> {
    case idle
    case success(result: T)
    case failure(error: Error)

    var result: T? {
        guard case let .success(result) = self else {
            return nil
        }

        return result
    }
}
