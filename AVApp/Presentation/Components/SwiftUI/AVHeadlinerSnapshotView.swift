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
            AVAsyncImage(url: headliner.profileImageUrl(.medium))
                .frame(height: 165)
                .cornerRadius(12.0)
                .clipped()
                .accessibilityHidden(true)
            Text(headliner.name)
                .avStyle(.paragraph)
            Text(headliner.characterName)
                .avStyle(.caption)
        }
        .accessibilityElement(children: .combine)
        .lineLimit(1)
        .frame(width: 143)
        .avCardDesign()
    }
}

#if DEBUG
#Preview {
    PreviewContainer {
        VStack {
            AVHeadlinerSnapshotView(headliner: .mock)
        }
    }
}
#endif
