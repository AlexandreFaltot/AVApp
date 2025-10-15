//
//  AVBackButton.swift
//  AVApp
//
//  Created by Alexandre Faltot on 15/10/2025.
//

import SwiftUI

struct AVBackButton: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(.avBackButton)
                .frame(width: 20, height: 28, alignment: .leading)
        }
        .padding(.vertical, 10.0)
        .padding(.trailing, 8.0)
        .accessibilityLabel(.back)
        .accessibilityHint(.navigatesToPreviousScreenAccessibility)
    }
}
