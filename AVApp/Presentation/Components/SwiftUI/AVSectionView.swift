//
//  AVSectionView.swift
//  AVApp
//
//  Created by Alexandre Faltot on 13/10/2025.
//

import SwiftUI

extension EnvironmentValues {
    @Entry var contentPadding: EdgeInsets = EdgeInsets(top: 0, leading: 16.0, bottom: 0, trailing: 16.0)
}

extension View {
    func contentPadding(_ value: EdgeInsets) -> some View {
        environment(\.contentPadding, value)
    }
}

struct AVSectionView<ContentView: View>: View {
    let title: String
    @Environment(\.contentPadding) var contentPadding
    @ViewBuilder let content: () -> ContentView

    init(title: String, @ViewBuilder content: @escaping () -> ContentView) {
        self.title = title
        self.content = content
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0.0) {
            Text(title)
                .avStyle(.header2)
                .padding(.horizontal, 16.0)
                .padding(.vertical, 8.0)
            content()
                .padding(contentPadding)
        }
        .accessibilityElement(children: .contain)
    }
}

#if DEBUG
#Preview {
    VStack(alignment: .leading) {
        AVSectionView(title: "Title") {
            Text("Section content")
                .avStyle(.paragraph)
        }
        AVSectionView(title: "Title") {
            ProgressView()
                .tint(.avYellow)
        }
        AVSectionView(title: "Title") {
            Text("Section content")
                .avStyle(.paragraph)
        }
        .contentPadding(EdgeInsets())
    }
    .background(Color.avPrimary)
}
#endif
