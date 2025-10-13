//
//  AVHeaderView.swift
//  AVApp
//
//  Created by Alexandre Faltot on 13/10/2025.
//


import SwiftUI

struct AVHeaderView: View {
    let title: String
    let subtitle: String

    var body: some View {
        VStack(alignment: .center, spacing: 16.0) {
            Text(title)
                .avStyle(.header1)
            Text(subtitle)
                .avStyle(.header2)
        }
        .padding(16.0)
    }
}

#Preview {
    AVHeaderView(title: "Title", subtitle: "Subtitle")
        .background(Color.avPrimary)
        .frame(width: 300)
}
