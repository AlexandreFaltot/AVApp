//
//  View+AllowRetry.swift
//  AVApp
//
//  Created by Alexandre Faltot on 09/10/2025.
//

import SwiftUI

extension EnvironmentValues {
    @Entry var allowRetry = true
}

extension View {
    func allowRetry(_ value: Bool) -> some View {
        environment(\.allowRetry, value)
    }
}
