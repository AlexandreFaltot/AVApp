//
//  ImageCache.swift
//  AVApp
//
//  Created by Alexandre Faltot on 10/10/2025.
//

import Foundation
import UIKit

enum ImageCacheManagerError: Error {
    case urlError, failedToFetchImage
}

class ImageCacheManager {
    private let cache = NSCache<NSString, UIImage>()

    static let shared = ImageCacheManager()

    func imageFromCacheOrLoad(_ url: String) async -> UIImage? {
        return try? await imageFromCacheOrLoad(URL(string: url))
    }

    func imageFromCacheOrLoad(_ url: URL?) async throws -> UIImage {
        guard let url else {
            throw ImageCacheManagerError.urlError
        }

        let urlNSString = url.absoluteString as NSString
        if let cachedImage = cache.object(forKey: urlNSString) {
            return cachedImage
        }

        guard let (data, _) = try? await URLSession.shared.data(from: url),
              let image = UIImage(data: data) else {
            throw ImageCacheManagerError.failedToFetchImage
        }

        cache.setObject(image, forKey: urlNSString)
        return image
    }
}
