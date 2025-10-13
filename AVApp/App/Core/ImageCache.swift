//
//  ImageCache.swift
//  AVApp
//
//  Created by Alexandre Faltot on 10/10/2025.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func setupImage(with urlString: String, placeholder: UIImage? = nil) {
        Task {
            self.image = placeholder
            if let image = await fetchImage(from: urlString) {
                self.image = image
            }
        }
    }

    private func fetchImage(from urlString: String) async -> UIImage? {
        let urlNSString = urlString as NSString
        if let cachedImage = imageCache.object(forKey: urlNSString) {
            return cachedImage
        }

        guard let url = URL(string: urlString),
              let (data, _) = try? await URLSession.shared.data(from: url),
              let image = UIImage(data: data) else {
            return nil
        }

        imageCache.setObject(image, forKey: urlNSString)
        return image
    }
}
