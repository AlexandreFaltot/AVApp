//
//  AVTextField.swift
//  AVApp
//
//  Created by Alexandre Faltot on 14/10/2025.
//

import SwiftUI
import Combine

struct AVTextField: View {
    var placeholder: String
    var text: Binding<String>
    var leadingIcon: ImageResource?

    init(_ placeholder: String, text: Binding<String>, leadingIcon: ImageResource? = nil) {
        self.placeholder = placeholder
        self.text = text
        self.leadingIcon = leadingIcon
    }

    var body: some View {
        HStack(spacing: 20.0) {
            if let leadingIcon {
                Image(leadingIcon)
                    .resizable()
                    .frame(width: 16.0, height: 16.0)
            }
            TextField("", text: text, prompt: Text(placeholder).foregroundColor(.avWhite))
                .foregroundStyle(Color.avWhite)
                .avStyle(.paragraph)
        }
        .padding(.horizontal, 12.0)
        .frame(height: 48.0)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.shadow(.inner(color: .black.opacity(0.25), radius: 4, y: 4)))
                .foregroundColor(.avDark)
        )
        .cornerRadius(12.0)
    }
}

#if DEBUG
#Preview {
    VStack {
        Spacer()
        AVTextField("", text: .constant("Text"), leadingIcon: .avSearch)
        AVTextField("", text: .constant("Text"))
        Spacer()
    }

    .background(.avPrimary)
}
#endif
