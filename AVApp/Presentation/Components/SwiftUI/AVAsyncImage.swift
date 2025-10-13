//
//  AVAsyncImage.swift
//  AVApp
//
//  Created by Alexandre Faltot on 13/10/2025.
//


import SwiftUI

struct AVAsyncImage: View {
    let url: URL?

    var body: some View {
        AVAsyncView {
            try await ImageCacheManager.shared.imageFromCacheOrLoad(url)
        } content: { data in
            Image(uiImage: data)
                .resizable()
                .scaledToFill()
        }
        .allowRetry(false)
        .displayErrorMessage(false)
    }
}