//
//  OnLoadExtension.swift
//  AVApp
//
//  Created by Alexandre Faltot on 09/10/2025.
//

import SwiftUI

extension View {
    // MARK: - Utils
    
    ///
    /// Creates a partial mask for the view, that show only the left side of the view
    ///
    /// - Parameter percent: The percentage of width to be displayed
    /// - Returns: The masked view
    /// 
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
    
    ///
    /// Setup an action to make when view has loaded
    ///
    /// - Parameter action: The action to make
    /// - Returns: A view with the action done on load
    ///
    func onLoad(perform action: (() -> Void)? = nil) -> some View {
        modifier(OnLoadViewModifier(action: action))
    }

    ///
    /// Setup the view to be constrained with the given size
    ///
    /// - Parameter size: The size of the view
    /// - Returns: A view with the frame constrained
    ///
    func frame(size: CGSize) -> some View {
        frame(width: size.width, height: size.height)
    }

    // MARK: - AV Design
    
    ///
    /// Sets a card design for the view
    ///
    /// - Parameters:
    ///   - borderWidth: The border width for the card
    ///   - padding: The padding for the card
    ///   - cornerRadius: The corner radius for the card
    ///   - shadowRadius: The shadow radius for the card
    ///   - shadowOpacity: The shadow opacity width for the card
    ///   - shadowOffset: The shadow offset width for the card
    ///
    /// - Returns: The view inside the card design
    ///
    func avCardDesign(borderWidth: CGFloat = 0.0, padding: CGFloat = 8.0, cornerRadius: CGFloat = 12.0, shadowRadius: CGFloat = 4.0, shadowOpacity: CGFloat = 0.25, shadowOffset: CGPoint = .init(x: 0.0, y: 4.0)) -> some View {
        self.padding(padding)
            .background(Color.avPrimary)
            .cornerRadius(cornerRadius)
            .overlay(RoundedRectangle(cornerRadius: cornerRadius).stroke(.avDark, lineWidth: borderWidth))
            .shadow(color: .black.opacity(shadowOpacity), radius: shadowRadius, x: shadowOffset.x, y: shadowOffset.y)
    }

    
    ///
    /// Sets the style for the view
    ///
    /// - Parameter style: The style to use
    /// - Returns: A view styled with the given information
    ///
    func avStyle(_ style: AVTextStyle) -> some View {
        font(Font(style.font))
            .foregroundStyle(.avWhite)
    }
}
