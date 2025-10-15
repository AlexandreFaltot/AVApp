//
//  AVMovieUITableViewCell.swift
//  AVApp
//
//  Created by Alexandre Faltot on 12/10/2025.
//

import UIKit

@IBDesignable
class AVUIMovieTableViewCell: AVUITableViewCell<AVUIMovieCell> {
    override func setupView() {
        self.insets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        super.setupView()
    }

    ///
    /// Sets up the view with the given model
    ///
    /// - Parameter model: The model that will be displayed by the view
    ///
    func setup(with movie: AVMovie) {
        self.isAccessibilityElement = false
        content.isAccessibilityElement = true
        content.accessibilityTraits = .button
        content.setup(with: movie)
    }
}
