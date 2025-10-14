//
//  AVUIImageView.swift
//  AVApp
//
//  Created by Alexandre Faltot on 13/10/2025.
//

import Foundation
import UIKit

@IBDesignable
class AVUIImageView: UIImageView {
    private let cacheManager: ImageCacheManager = Module.shared.resolve()

    lazy var activityIndicator = {
        let indicator = UIActivityIndicatorView()
        indicator.tintColor = .avWhite
        return indicator
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    func setupView() {
        addConstrainedSubview(activityIndicator)
    }

    func setupImage(with url: URL?) {
        Task { @MainActor in
            self.activityIndicator.startAnimating()
            if let image = try? await cacheManager.imageFromCacheOrLoad(url) {
                self.image = image
            }
            self.activityIndicator.stopAnimating()
        }
    }
}
