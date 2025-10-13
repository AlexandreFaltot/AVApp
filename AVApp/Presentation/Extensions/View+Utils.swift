//
//  OnLoadExtension.swift
//  AVApp
//
//  Created by Alexandre Faltot on 09/10/2025.
//

import SwiftUI


extension View {
    func partialMask(_ percent: Double) -> some View {
        mask(
            GeometryReader { geometry in
                let width = geometry.size.width * percent
                Rectangle()
                    .frame(width: width)
                    .position(x: width / 2, y: geometry.size.height / 2)
            }
        )
    }

    func avStyle(_ style: AVTextStyle) -> some View {
        font(Font(style.font))
            .foregroundStyle(.avWhite)
    }

    func onLoad(perform action: (() -> Void)? = nil) -> some View {
        modifier(OnLoadViewModifier(action: action))
    }

    func frame(size: CGSize) -> some View {
        frame(width: size.width, height: size.height)
    }
}
