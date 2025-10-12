//
//  OnLoadViewModifier.swift
//  AVApp
//
//  Created by Alexandre Faltot on 09/10/2025.
//

import SwiftUI

struct OnLoadViewModifier: ViewModifier {
    // MARK: - State properties
    @State var hasLoaded = false

    // MARK: - Properties
    let action: (() -> Void)?

    // MARK: - Body
    func body(content: Content) -> some View {
        content.task {
            guard !hasLoaded else { return }
            hasLoaded = true
            action?()
        }
    }
}
