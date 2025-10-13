//
//  AVHeadlinerSnapshotView.swift
//  AVApp
//
//  Created by Alexandre Faltot on 13/10/2025.
//


import SwiftUI

struct AVHeadlinerSnapshotView: View {
    let headliner: AVMovieHeadliner

    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            AVAsyncImage(url: headliner.imageUrl)
                .frame(height: 165)
                .cornerRadius(12.0)
                .clipped()
            Text(headliner.name)
                .avStyle(.paragraph)
            Text(headliner.characterName)
                .avStyle(.caption)
        }
        .lineLimit(1)
        .frame(width: 143)
        .padding(8.0)
        .background(Color.avPrimary)
        .cornerRadius(12.0)
        .shadow(radius: 4, y: 4)
    }
}

#Preview {
    VStack {
        AVHeadlinerSnapshotView(headliner: .mock)
    }
}
