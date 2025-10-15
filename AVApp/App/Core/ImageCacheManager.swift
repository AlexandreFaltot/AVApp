//
//  ImageCache.swift
//  AVApp
//
//  Created by Alexandre Faltot on 10/10/2025.
//

import Foundation
import UIKit

// MARK: - ImageCacheManager errors
enum ImageCacheManagerError: Error {
    case urlError, failedToFetchImage
}

// MARK: - ImageCacheManager
class ImageCacheManager {
    private let cache = NSCache<NSString, UIImage>()
    private let urlSession: URLSession

    init(urlSession: URLSession = Module.shared.resolve()) {
        self.urlSession = urlSession
    }

    ///
    /// Loads an image from cache. If no image was found, tries to
    /// get it from the network
    ///
    /// - Parameter url: The url of the image
    /// - Returns: The image if found or downloaded
    ///
    func imageFromCacheOrLoad(_ url: URL?) async throws -> UIImage {
        // Ensure there is an url
        guard let url else {
            throw ImageCacheManagerError.urlError
        }

        // Try to get the cached image
        let urlNSString = url.absoluteString as NSString
        if let cachedImage = cache.object(forKey: urlNSString) {
            return cachedImage
        }

        // Try to get the network image
        guard let (data, _) = try? await urlSession.data(from: url),
              let image = UIImage(data: data) else {
            throw ImageCacheManagerError.failedToFetchImage
        }

        // Store the image in cache
        cache.setObject(image, forKey: urlNSString)
        return image
    }
}
