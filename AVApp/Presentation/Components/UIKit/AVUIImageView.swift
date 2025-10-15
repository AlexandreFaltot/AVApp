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
    // MARK: - Private properties
    private let cacheManager: ImageCacheManager = Module.shared.resolve()

    private lazy var activityIndicator = {
        let indicator = UIActivityIndicatorView()
        indicator.color = .avWhite
        return indicator
    }()

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    // MARK: - Public methods
    
    func setupView() {
        addConstrainedSubview(activityIndicator)
    }

    ///
    /// Try to load image from `cacheManager` based on the given `url`
    ///
    /// - Parameter url: The url of the image
    ///
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
