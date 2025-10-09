//
//  OnLoadViewModifier.swift
//  AVApp
//
//  Created by Alexandre Faltot on 09/10/2025.
//


import SwiftUI

struct OnLoadViewModifier: ViewModifier {
    @State var hasLoaded = false
    var onLoad: () -> Void

    func body(content: Content) -> some View {
        content
            .onAppear {
                if (!hasLoaded) {
                    onLoad()
                }
                hasLoaded = true
            }
    }
}