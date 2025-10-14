//
//  AVAsyncImage.swift
//  AVApp
//
//  Created by Alexandre Faltot on 13/10/2025.
//

import SwiftUI

struct AVAsyncImage: View {
    let url: URL?
    let cacheManager: ImageCacheManager

    init(url: URL?,
         cacheManager: ImageCacheManager = Module.shared.resolve()) {
        self.url = url
        self.cacheManager = cacheManager
    }

    var body: some View {
        AVAsyncView {
            try await cacheManager.imageFromCacheOrLoad(url)
        } content: { data in
            Image(uiImage: data)
                .resizable()
                .scaledToFill()
        }
        .allowRetry(false)
        .displayErrorMessage(false)
    }
}
