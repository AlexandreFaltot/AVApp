//
//  OnLoadExtension.swift
//  AVApp
//
//  Created by Alexandre Faltot on 09/10/2025.
//

import SwiftUI

extension View {
    // MARK: - Utils

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

    func onLoad(perform action: (() -> Void)? = nil) -> some View {
        modifier(OnLoadViewModifier(action: action))
    }

    func frame(size: CGSize) -> some View {
        frame(width: size.width, height: size.height)
    }

    // MARK: - AV Design

    func avCardDesign(borderWidth: CGFloat = 0.0, padding: CGFloat = 8.0, cornerRadius: CGFloat = 12.0, shadowRadius: CGFloat = 4.0, shadowOpacity: CGFloat = 0.25, shadowOffset: CGPoint = .init(x: 0.0, y: 4.0)) -> some View {
        self.padding(padding)
            .background(Color.avPrimary)
            .cornerRadius(cornerRadius)
            .overlay(RoundedRectangle(cornerRadius: cornerRadius).stroke(.avDark, lineWidth: borderWidth))
            .shadow(color: .black.opacity(shadowOpacity), radius: shadowRadius, x: shadowOffset.x, y: shadowOffset.y)
    }

    func avStyle(_ style: AVTextStyle) -> some View {
        font(Font(style.font))
            .foregroundStyle(.avWhite)
    }
}
