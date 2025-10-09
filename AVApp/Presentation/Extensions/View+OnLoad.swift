//
//  OnLoadExtension.swift
//  AVApp
//
//  Created by Alexandre Faltot on 09/10/2025.
//


import SwiftUI

extension View {
    func onLoad(_ perform: @escaping () -> Void) -> some View {
        self.modifier(OnLoadViewModifier(onLoad: perform))
    }
}